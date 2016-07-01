class Thermostat < ActiveRecord::Base
  UNIQUE_FIELDS = %w(uuid access_token).freeze

  has_many :subscribers, inverse_of: :thermostat, dependent: :destroy
  has_many :users, through: :subscribers
  has_one :temperature, -> { where type: 'Temperature' }, class_name: 'Sensor', dependent: :destroy, required: true

  validates :name, presence: true

  before_create :set_disabled, unless: :enabled?
  before_save :assign_uuid, :assign_access_token
  around_save :save_managing_uniqueness,
    if: Proc.new { |thermostat| UNIQUE_FIELDS.map{ |field| thermostat.send("#{field}_changed?") }.include?(true) }

  def to_param
    uuid
  end


  private

  def set_disabled
    self.enabled = false
    true
  end

  def save_managing_uniqueness
    attempts ||= 0
    self.class.connection.execute('SAVEPOINT before_record_create;')
    yield
    self.class.connection.execute('RELEASE SAVEPOINT before_record_create;')
  rescue ActiveRecord::RecordNotUnique => error
    attempts += 1
    if attempts < 3
      duplicated_field = error.message[/Key \((\w+)\)/, 1]
      send("assign_#{duplicated_field}", true) if duplicated_field && UNIQUE_FIELDS.include?(duplicated_field)
      self.class.connection.execute('ROLLBACK TO SAVEPOINT before_record_create;')
      retry
    else
      raise error, 'Retries exhausted'
    end
  end

  def assign_uuid(force = false)
    self.uuid = SecureRandom.uuid if uuid.nil? || force
  end

  def assign_access_token(force = false)
    self.access_token = SecureRandom.uuid if access_token.nil? || force
  end
end

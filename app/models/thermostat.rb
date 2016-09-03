class Thermostat < ApplicationRecord
  UNIQUE_FIELDS = %w(uuid access_token).freeze

  has_many :subscribers, inverse_of: :thermostat, dependent: :destroy
  has_many :users, through: :subscribers
  belongs_to :temperature, class_name: 'Temperature', dependent: :destroy
  belongs_to :humidity, class_name: 'Humidity', dependent: :destroy
  has_one :manual_program, dependent: :destroy, inverse_of: :thermostat

  enum status: { standby: 0, unknown: 1, heating: 2, cooling: 3 }
  enum program_status: { manual: 0 } # auto: 1

  before_validation :set_default_values, on: :create
  before_save :assign_uuid, :assign_access_token
  around_save :save_managing_uniqueness,
    if: proc { |thermostat| UNIQUE_FIELDS.map{ |field| thermostat.send("#{field}_changed?") }.include?(true) }
  before_update :update_started_at, if: :status_changed?

  validates :name, :status, :program_status, presence: true

  accepts_nested_attributes_for :temperature, :humidity, :manual_program

  def to_param
    uuid
  end

  def program
    send "#{program_status}_program"
  end

  def active?
    heating? || cooling?
  end

  def update_started_at
    self.started_at = Time.now if active?
  end


  private

  def set_default_values
    self.enabled = false unless enabled?
    self.status         ||= :unknown
    self.program_status ||= :manual
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

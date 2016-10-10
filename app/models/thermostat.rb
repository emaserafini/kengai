class Thermostat < ApplicationRecord
  include SafeUniqueness

  UNIQUE_FIELDS = %w(uuid access_token).freeze

  enum status: { standby: 0, unknown: 1, heating: 2 }
  enum program_status: { manual: 0, auto: 1 }

  has_many :subscribers, inverse_of: :thermostat, dependent: :destroy
  has_many :users, through: :subscribers
  belongs_to :temperature, class_name: 'Temperature', dependent: :destroy
  belongs_to :humidity, class_name: 'Humidity', dependent: :destroy

  accepts_nested_attributes_for :temperature, :humidity, update_only: true

  before_save :assign_uuid, :assign_access_token
  before_update :update_started_at, if: :status_changed?

  validates_presence_of :name, :status, :program_status
  validates_numericality_of :offset_temperature, greater_than_or_equal_to: 0
  validates_numericality_of :manual_program_target_temperature
  validates_numericality_of :minimum_run, only_integer: true, greater_than_or_equal_to: 0

  def to_param
    uuid
  end

  def program
    send "#{program_status}_program"
  end

  def manual_program
    OpenStruct.new target_temperature: manual_program_target_temperature
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

  def assign_uuid(force = false)
    self.uuid = SecureRandom.uuid if uuid.nil? || force
  end

  def assign_access_token(force = false)
    self.access_token = SecureRandom.uuid if access_token.nil? || force
  end
end

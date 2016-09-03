class ManualProgram < ApplicationRecord
  belongs_to :thermostat

  enum mode: { heating: 0, cooling: 1 }

  validates :mode, presence: true
  validates :target_temperature, numericality: true
  validates :deviation_temperature, numericality: { greater_than_or_equal_to: 0 }
  validates :minimum_run, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :set_default_values


  private

  def set_default_values
    self.mode                  ||= :heating
    self.target_temperature    ||= 20
    self.deviation_temperature ||= 0
    self.minimum_run           ||= 0
  end
end

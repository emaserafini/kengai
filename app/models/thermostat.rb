class Thermostat < ActiveRecord::Base
  validates :name, presence: true
end

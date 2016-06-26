class Thermostat < ActiveRecord::Base
  has_many :subscribers, inverse_of: :thermostat
  has_many :users, through: :subscribers

  validates :name, presence: true
end

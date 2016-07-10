class Subscriber < ApplicationRecord
  belongs_to :user
  belongs_to :thermostat
end

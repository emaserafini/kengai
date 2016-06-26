class Subscriber < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :thermostat, required: true
end

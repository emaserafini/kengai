FactoryGirl.define do
  factory :temperature, class: Temperature do
    after(:build) do |temperature|
      temperature.thermostat ||= create :thermostat, temperature: temperature
    end
  end
end

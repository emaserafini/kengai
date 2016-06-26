FactoryGirl.define do
  factory :subscriber do
    association :user
    association :thermostat
    admin false
  end
end

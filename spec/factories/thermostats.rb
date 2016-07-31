FactoryGirl.define do
  factory :thermostat do
    sequence(:name) { |n| "home \##{n}" }
    temperature
    humidity

    transient do
      user { create :confirmed_user }
      admin true
    end

    after(:build) do |thermostat, evaluator|
      create :subscriber, user: evaluator.user, thermostat: thermostat, admin: evaluator.admin
    end
  end
end

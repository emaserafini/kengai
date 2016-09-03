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
      create :manual_program, thermostat: thermostat
    end

    trait :enabled do
      enabled true
    end

    trait :manual do
      program_status :manual
    end

    factory :manual_thermostat, traits: [ :enabled, :manual ]
  end
end

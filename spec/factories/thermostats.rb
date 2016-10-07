FactoryGirl.define do
  factory :thermostat do
    sequence(:name) { |n| "home \##{n}" }
    association :temperature, strategy: :build
    association  :humidity, strategy: :build
    enabled true
    status :unknown
    program_status :manual
    offset_temperature 2
    manual_program_target_temperature 20
    minimum_run 15

    transient do
      user { create :confirmed_user }
      admin true
    end

    after(:build) do |thermostat, evaluator|
      create :subscriber, user: evaluator.user, thermostat: thermostat, admin: evaluator.admin
    end

    trait :disabled do
      enabled false
    end
  end
end

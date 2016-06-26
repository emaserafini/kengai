FactoryGirl.define do
  factory :thermostat do
    sequence(:name) { |n| "home \##{n}" }

    transient do
      user { create :user }
      admin true
    end

    after(:create) do |thermostat, evaluator|
      create :subscriber, user: evaluator.user, thermostat: thermostat, admin: evaluator.admin
    end
  end
end
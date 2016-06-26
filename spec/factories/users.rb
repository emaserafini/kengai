FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    factory :confirmed_user do
      after(:create, &:confirm)
    end
  end
end

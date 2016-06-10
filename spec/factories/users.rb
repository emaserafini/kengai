FactoryGirl.define do
  factory :user do
    email 'foo@example.com'
    password 'password'
    password_confirmation 'password'

    factory :confirmed_user do
      after(:create) { |user| user.confirm }
    end
  end
end
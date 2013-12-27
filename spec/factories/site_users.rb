# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_user do
    email                 "user#{SecureRandom.hex(10)}@chess.com"
    password              "password"
    password_confirmation "password"
  end
end

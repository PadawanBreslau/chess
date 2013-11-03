# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_user do
    email                 "user@chess.com"
    password              "password"
    password_confirmation "password"
  end
end

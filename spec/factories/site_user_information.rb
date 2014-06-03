# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_user_information do
    association :site_user, strategy: :build
    name "Name"
    surname "Surname"
    nick "GraveDigger"
    country_code "us"
  end
end

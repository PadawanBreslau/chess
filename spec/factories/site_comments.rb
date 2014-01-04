# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_comment do
    content "Very important comment"
    association :site_user, strategy: :build
  end
end

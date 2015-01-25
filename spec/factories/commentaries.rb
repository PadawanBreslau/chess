# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commentary do
    comment "Very important commentary"
    association :site_user, strategy: :build
    association :chess_move, strategy: :build
  end
end

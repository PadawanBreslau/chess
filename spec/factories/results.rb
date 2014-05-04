FactoryGirl.define do
  factory :result do
    association :player, fide_id: 12345
    association :tournament
  end
end

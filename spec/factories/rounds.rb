# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :round do
    date Date.today - 10.days
    sequence(:round_number) {|n| n+99}

    factory :round_with_games do
      after(:create) do |round, _|
        5.times do
          FactoryGirl.create(:chess_game, round: round)
        end
      end
    end
  end
end

# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :tournament do
    tournament_name "Tournament 1"
    tournament_start Date.today - 10.days
    tournament_finish Date.today - 1.day

    factory :tournament_with_rounds do
      after(:create) do |tournament, _|
        5.times do
          FactoryGirl.create(:round, tournament: tournament)
        end
      end
    end

    factory :tournament_with_rounds_and_games do
      after(:create) do |tournament, _|
        5.times do
          FactoryGirl.create(:round_with_games, tournament: tournament)
        end
      end
    end

  end
end


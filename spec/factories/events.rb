# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :event do
    event_name "Event 1"
    event_start Date.today - 10.days
    event_finish Date.today - 1.day

    factory :event_with_tournaments do
      after(:create) do |event, _|
        5.times do |i|
          FactoryGirl.create(:tournament, tournament_name: "Tournament #{i}", event: event)
        end
      end
    end

    factory :event_with_tournaments_and_rounds do
      after(:create) do |event, _|
        5.times do |i|
          FactoryGirl.create(:tournament_with_rounds, tournament_name: "Tournament #{i}", event: event)
        end
      end
    end

    factory :event_with_tournaments_and_rounds_and_games do
      after(:create) do |event, _|
        5.times do |i|
          FactoryGirl.create(:tournament_with_rounds_and_games, tournament_name: "Tournament #{i}", event: event)
        end
      end
    end
  end
end


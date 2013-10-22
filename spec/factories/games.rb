# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :game do
    result 1
    association :white_player, factory: :player, surname: "Alrighty", strategy: :build
    association :black_player, factory: :player, surname: "Bewerly", strategy: :build

    factory :game_with_players do
      association :white_player, factory: :player, surname: "Amerigo", fide_id: 9998887, strategy: :build
      association :black_player, factory: :player, surname: "Beowulf", fide_id: 9998889, strategy: :build
    end

  end 
end	
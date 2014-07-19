# -*- encoding : utf-8 -*-
require 'securerandom'

FactoryGirl.define do
  factory :chess_game do
    result 1

    association :white_player, factory: :player, surname: "Alrighty", strategy: :build
    association :black_player, factory: :player, surname: "Bewerly", strategy: :build

    factory :chess_game_with_players do
      association :white_player, factory: :player, surname: "Amerigo", fide_id: 9998887, strategy: :build
      association :black_player, factory: :player, surname: "Beowulf", fide_id: 9998889, strategy: :build


      factory :chess_game_with_players_and_round do
        association :round
      end

    end

    factory :chess_game_with_random_players do
      association :white_player, factory: :player, surname: Array.new(8){[ *'a'..'z'].sample}.join, fide_id: Random.rand(10000000), strategy: :build
      association :black_player, factory: :player, surname: Array.new(8){[ *'a'..'z'].sample}.join, fide_id: Random.rand(10000000), strategy: :build
    end

    factory :chess_game_with_created_random_players do
      association :white_player, factory: :player_with_fide_id, surname: Array.new(8){[ *'a'..'z'].sample}.join, fide_id: Random.rand(10000000)
      association :black_player, factory: :player_with_fide_id, surname: Array.new(8){[ *'a'..'z'].sample}.join, fide_id: Random.rand(99999999)
    end
  end
end

# -*- encoding : utf-8 -*-
require 'spec_helper'


describe Player do
  context 'creating player' do
    it 'should create player with only name data' do
      FactoryGirl.build(:player).should be_valid
    end

    it 'should create player with extra data' do
      FactoryGirl.build(:player_with_date_of_birth).should be_valid
      FactoryGirl.build(:player_with_fide_id).should be_valid
    end

    it 'should not create player without name' do
      FactoryGirl.build(:player, name: nil).should_not be_valid
    end

    it 'should not create player without surname' do
      FactoryGirl.build(:player, surname: nil).should_not be_valid
    end

    it 'should not create player with too short surname' do
      FactoryGirl.build(:player, name: 'a').should_not be_valid
    end

    it 'should not create player with too long surname' do
      FactoryGirl.build(:player, name: 'a'*33).should_not be_valid
    end

    it 'should not create player with too short surname' do
      FactoryGirl.build(:player, surname: 'a').should_not be_valid
    end

    it 'should not create player with too long surname' do
      FactoryGirl.build(:player, surname: 'a'*33).should_not be_valid
    end

    it 'should create player without middlename' do
      FactoryGirl.build(:player, middlename: nil).should be_valid
    end

    it 'should not allow two players with same name and surname or same fide_id' do
      FactoryGirl.create(:player, fide_id:1111111)
      expect{FactoryGirl.create(:player)}.to raise_error
      expect{FactoryGirl.create(:player, name: "Arnold", fide_id: 1111111)}.to raise_error
      expect{FactoryGirl.create(:player, name: "Arnold", fide_id: 1112223)}.not_to raise_error
    end

    it 'should not allow any chars besides from letters and hyphens and spaces' do
      FactoryGirl.build(:player, name: 'a12345').should_not be_valid
      FactoryGirl.build(:player, name: 'abcdef').should be_valid

      FactoryGirl.build(:player, middlename: 'a12345').should_not be_valid
      FactoryGirl.build(:player, middlename: 'abcdef').should be_valid

      FactoryGirl.build(:player, surname: 'a12345').should_not be_valid
      FactoryGirl.build(:player, surname: 'abcdef').should be_valid

      FactoryGirl.build(:player, name: 'Beata', surname: 'Kądziołka-Zawadzka').should be_valid
      FactoryGirl.build(:player, name: 'José Enrique').should be_valid
    end

    it 'should look for a player in FIDE database and assign fide_id to player' do
      player = FactoryGirl.create(:player, name: "Jolanta", surname: "Zawadzka")
      player.fide_id.should eql 1122320
      player.to_name.should eql "Zawadzka, Jolanta"
      player.tournaments_with_games.should be_empty

      player = FactoryGirl.create(:player, name: "Beata", surname: "Kądziołka")
      player.fide_id.should eql 1119990
      player.to_name.should eql "Kądziołka, Beata"
      player.tournaments_with_games.should be_empty
    end

    it 'should create player with photo attachment' do
      (player = FactoryGirl.create(:player_with_photo)).should be_valid
      player.photo.should_not be_nil
    end
  end

  context 'fide rating' do
    it 'should not have any fide rating initialy' do
      player = FactoryGirl.create(:player)
      player.fide_ratings.should be_empty
    end

    it 'should have a fid rating when we create one' do
      player = FactoryGirl.create(:player, name: "Jolanta", surname: "Zawadzka")
      player.fide_ratings.should be_empty
      player.fide_id.should eql 1122320
      fide_rating = FactoryGirl.create(:fide_rating, fide_id: player.fide_id)
      player.fide_ratings.should_not be_empty
      player.fide_ratings.first.should eql fide_rating
      fide_rating.player.should eql player
    end
  end

  context 'highest fide rating' do
    it 'should return empty if no rating' do
      player = FactoryGirl.create(:player)
      player.lowest_rating.should eq '-'
      player.highest_rating.should eq '-'
      player.current_rating.should eq '-'
      player.get_player_ratings.should be_empty
    end

    it 'should return higest rating as higest an newest as current' do
      player = FactoryGirl.create(:player, fide_id: 12213)
      highest = FactoryGirl.create(:fide_rating, fide_id: player.fide_id, rating: 2222, year: 2012, month: 12)
      different = FactoryGirl.create(:fide_rating, fide_id: player.fide_id, rating: 2181, year: 2013, month: 1)
      current = FactoryGirl.create(:fide_rating, fide_id: player.fide_id, rating: 2121, year: 2013, month: 2)
      player.get_highest_rating.should eq highest
      player.get_current_rating.should eq current
      player.get_lowest_rating.should eq current

      player.get_player_ratings.should_not be_empty

      player.highest_rating.should eq PlayerHelper::format_rating_output(highest.rating, highest.year, highest.month)
      player.current_rating.should eq PlayerHelper::format_rating_output(current.rating, current.year, current.month)
    end

    it 'should get player results' do
      player = FactoryGirl.create(:player, fide_id: 97869)
      player.get_player_results("white").should be_empty
      player.get_player_results("black").should be_empty
      player.get_player_results("wrong").should be_empty
      player.get_player_activities.should be_empty
    end
  end

  context 'find or create player' do
    before do
      @player = FactoryGirl.create(:player, name: 'Andy', surname: 'Warhol', middlename: nil)
    end

    it 'should find a plyaer if exists' do
      Player.find_or_create_player_by_string("Warhol, Andy").should eql @player
    end

    it 'should add new player if not exists' do
      expect{Player.find_or_create_player_by_string("Beaver, Barry")}.to change(Player, :count).by(1)
    end

    it 'should use middlename too' do
      @player = FactoryGirl.create(:player, name: 'Cassey', surname: 'Cassiddy', middlename: 'C')
    end
  end


end


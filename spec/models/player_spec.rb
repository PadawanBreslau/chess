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
      
      player = FactoryGirl.create(:player, name: "Beata", surname: "Kądziołka")
      player.fide_id.should eql 1119990
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

end 

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe FideRating do
  context 'creating single fide rating record' do

     it 'should create simple fide ratig object' do
       FactoryGirl.build(:fide_rating).should be_valid
     end

     it 'should not allow FIDE rating with improper data' do
       FactoryGirl.build(:fide_rating, rating: 999).should_not be_valid
       FactoryGirl.build(:fide_rating, year: 1900).should_not be_valid
       FactoryGirl.build(:fide_rating, month: 13).should_not be_valid
       FactoryGirl.build(:fide_rating, fide_id: "XXX").should_not be_valid
     end

  end

  context 'Downloading new rating list' do
    it 'should not allow to pass invalid arguments' do
      expect{FideRating.download_and_parse_rating("a","b")}.to raise_error(ArgumentError)
      expect{FideRating.download_and_parse_rating(2013,13)}.to raise_error(ArgumentError)
    end

    it 'should return false if time period is not available yet or the file is missing' do
      FideRating.download_and_parse_rating(2039,12).should eql false
    end

    it 'should download and parse new rating list' do
      FideRating.download_and_parse_rating(2012,12).should eql true
    end

    it 'should download and parse new rating list and add fide ratings' do
      player = FactoryGirl.create(:player, name: "Jolanta", surname: "Zawadzka")
      player2 = FactoryGirl.create(:player, name: "Beata", surname: "Kądziołka")
      FideRating.download_and_parse_rating(2012,12).should eql true
      player.reload
      player2.reload
      player.fide_ratings.should_not be_empty
      player2.fide_ratings.should_not be_empty
    end



  end
end

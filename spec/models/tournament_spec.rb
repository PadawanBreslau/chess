require 'spec_helper'

describe Tournament do
  context 'creating tournaments' do
    it 'should create simple tournament' do
      FactoryGirl.build(:tournament).should be_valid
    end

    it 'should create tournament with additional informations' do
      FactoryGirl.build(:tournament, round_number: 9).should be_valid
      FactoryGirl.build(:tournament, round_number: 99).should be_valid
      FactoryGirl.build(:tournament, round_number: 1000).should_not be_valid
      FactoryGirl.build(:tournament, round_number: 0).should_not be_valid
      FactoryGirl.build(:tournament, round_number: 'a').should_not be_valid
      FactoryGirl.build(:tournament, is_finished: true).should be_valid
      FactoryGirl.build(:tournament, is_finished: false).should be_valid
      FactoryGirl.build(:tournament, place: "aaaa").should be_valid
      FactoryGirl.build(:tournament, place: 1234).should_not be_valid
      FactoryGirl.build(:tournament, external_transmition_url: "http://euro2013.chessdom.com/").should be_valid
      FactoryGirl.build(:tournament, external_transmition_url: "aaaa").should_not be_valid
      FactoryGirl.build(:tournament, external_transmition_url: 1234).should_not be_valid
      FactoryGirl.build(:tournament, url: "http://euro2013.chessdom.com/").should be_valid
      FactoryGirl.build(:tournament, url: "euro2013.chessdom.com").should be_valid
      FactoryGirl.build(:tournament, url: "euro2013chessdomcom").should_not be_valid
    end

    it 'should not create tournament with start date after finish date' do
      FactoryGirl.build(:tournament, tournament_start: Date.today, tournament_finish: Date.today - 1.day).should_not be_valid
    end
  end

  context 'creating rounds after creating or updating tournaments' do

    it 'should never create round when rounds are already created' do
      rounds = [FactoryGirl.create(:round)]
      expect{@t1 = FactoryGirl.create(:tournament, round_number: 9, rounds: rounds)}.not_to raise_error
      @t1.rounds.count.should eql 1
    end

    it 'should create rounds when round number is defined, but tournament has no rounds' do
      expect{@t1 = FactoryGirl.build(:tournament)}.not_to raise_error
      @t1.rounds.should be_empty
      @t2 = FactoryGirl.create(:tournament, tournament_name: "Tournament 2",  round_number: 9)
      @t2.rounds.size.should eql 9
    end
  end

  context 'tournament should have games through rounds' do
    it 'should have no games if no rounds' do
      FactoryGirl.create(:tournament).games.should be_empty
    end

    it 'should not have games if rounds present, but without rounds' do
      FactoryGirl.create(:tournament_with_rounds).games.should be_empty
    end

    it 'should have games if rounds present with rounds' do
      FactoryGirl.create(:tournament_with_rounds_and_games).games.should_not be_empty
    end
  end
end

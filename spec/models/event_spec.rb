require 'spec_helper'

describe Event do
  context 'creating events' do
    it 'should create empty events' do
      FactoryGirl.build(:event).should be_valid
      FactoryGirl.build(:event, url: 'http://chess.com/').should be_valid
      FactoryGirl.build(:event, url: 'chess.com').should be_valid
      FactoryGirl.build(:event, url: 'chesscom').should_not be_valid
    end

    it 'should not create event hen start date is after finish' do
      FactoryGirl.build(:event, event_start: Date.today, event_finish: Date.today - 1.day)
    end
  end

  context 'accesing tournament data' do
    it 'should be able to create with tournament' do
      expect{@ev = FactoryGirl.create(:event_with_tournaments)}.not_to raise_error
      @ev.tournaments.count.should eql 5
    end

    it 'should be able to create with tournaments and rounds' do
      expect{@ev = FactoryGirl.create(:event_with_tournaments_and_rounds)}.not_to raise_error
      @ev.tournaments.count.should eql 5
      @ev.rounds.count.should eql 25
    end

    it 'should be able to create tournemanents and rounds and games' do
      expect{@ev = FactoryGirl.create(:event_with_tournaments_and_rounds_and_games)}.not_to raise_error
      @ev.tournaments.count.should eql 5
      @ev.rounds.count.should eql 25
      @ev.games.should_not be_empty
      @ev.games.count.should eql 125
    end
  end
end

require 'spec_helper'

describe Result do
  context 'creating results' do
    it 'should create simple result' do
      FactoryGirl.build(:result).should be_valid
    end

    it 'should have empty initial values' do
      expect{ @result = FactoryGirl.create(:result) }.not_to raise_error
      @result.player.should_not be_nil
      @result.tournament.should_not be_nil
      @result.points.should eq 0.0
      @result.berger.should eq 0.0
      @result.bucholtz.should eq 0.0
      @result.mini_bucholtz.should eq 0.0
      @result.progress.should eq 0.0
      @result.games_count.should eq 0
    end
  end
end

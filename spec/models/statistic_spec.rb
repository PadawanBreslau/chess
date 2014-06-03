require 'spec_helper'

describe Statistic do
  context 'creating statistics' do
    it 'should create a simple statistic' do
      FactoryGirl.build(:statistic).should be_valid
    end

    it 'should not create statistic if statistic exists' do
      FactoryGirl.create(:statistic)
      expect{FactoryGirl.create(:statistic)}.to raise_error
    end
  end
end

require 'spec_helper'

describe SiteComment do
  context 'creating site comment' do
    it 'should create site comment' do
      FactoryGirl.build(:site_comment).should be_valid
      expect{FactoryGirl.create(:site_comment)}.not_to raise_error
    end

    it 'content should have desired length' do
      FactoryGirl.build(:site_comment, content: nil).should_not be_valid
      FactoryGirl.build(:site_comment, content: '').should_not be_valid
      FactoryGirl.build(:site_comment, content: 'a').should be_valid
      FactoryGirl.build(:site_comment, content: 'a'*2**10).should be_valid
      FactoryGirl.build(:site_comment, content: 'a'*(2**10+1)).should_not be_valid
    end
  end
end

require 'spec_helper'

describe SiteUser do
  context 'Creating site user' do
    it 'should create simple user' do
      FactoryGirl.build(:site_user).should be_valid
    end
  end

  context 'Creating user data' do
    before do
      @user = FactoryGirl.create(:site_user, email: "createuser@chess.ex")
    end

    it 'should have user information by default' do
      @user.site_user_information.should_not be_nil
      @user.site_user_information.reputation.should eql 0.0
    end

    it 'should not have articles while created' do
      @user.articles.should be_empty
      @user.blog_entries.should be_empty
    end

  end
end

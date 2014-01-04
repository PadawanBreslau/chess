require 'spec_helper'

describe SiteUser do
  context 'Creating site user' do
    it 'should create simple user' do
      FactoryGirl.build(:site_user).should be_valid
    end

    it 'should not have user information by default' do
      FactoryGirl.create(:site_user).site_user_information.should be_nil
    end

    it 'should not have articles while created' do
      FactoryGirl.create(:site_user).articles.should be_empty
    end

  end
end

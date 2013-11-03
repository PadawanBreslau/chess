require 'spec_helper'

describe SiteUser do
  context 'Creating site user' do
    it 'should create simple user' do
      FactoryGirl.build(:site_user).should be_valid
    end
  end
end

require 'spec_helper'

describe SiteUserInformation do
  context 'creating site user informaton' do
    it 'should create a simple image information' do
      FactoryGirl.build(:site_user_information).should be_valid
    end

    it 'should check data correctness' do
      FactoryGirl.build(:site_user_information, name: nil).should be_valid
      FactoryGirl.build(:site_user_information, name: "a").should be_valid
      FactoryGirl.build(:site_user_information, name: "a"*25).should_not be_valid
      FactoryGirl.build(:site_user_information, surname: nil).should be_valid
      FactoryGirl.build(:site_user_information, surname: "a").should be_valid
      FactoryGirl.build(:site_user_information, surname: "a"*25).should_not be_valid
      FactoryGirl.build(:site_user_information, nick: nil).should be_valid
      FactoryGirl.build(:site_user_information, nick: "a").should be_valid
      FactoryGirl.build(:site_user_information, nick: "a"*25).should_not be_valid
      FactoryGirl.build(:site_user_information, country_code: nil).should be_valid
      FactoryGirl.build(:site_user_information, reputation: 10.0).should be_valid
      FactoryGirl.build(:site_user_information, reputation: 100.1).should_not be_valid
      FactoryGirl.build(:site_user_information, date_of_birth: Date.today).should_not be_valid
    end

    it 'should be able to create site user inforamtion' do
     expect{FactoryGirl.create(:site_user_information)}.not_to raise_error
    end

    it 'last active at should be still nil' do
      info = FactoryGirl.create(:site_user_information)
      info.last_active_at.should be_nil
    end

    it 'should retutn fullname and nickname' do
      user = FactoryGirl.create(:site_user_information, name: "Alan", surname: "Adams", nick: "ATeam")
      user.fullname.should eql "Alan Adams"
      user.nickname.should eql "ATeam"
    end
#TODO test logging
  end

  context 'online status' do
    it 'should be able to check if online' do
      user_info = FactoryGirl.build(:site_user_information)
      user_info.online?.should be_false
      user_info.online_icon_name.should eq 'offline'
      user_info.update_attribute(:last_active_at, Time.new-1.minute)
      user_info.online?.should be_true
      user_info.online_icon_name.should eq 'online'
      user_info.update_attribute(:last_active_at, Time.new-6.minute)
      user_info.online?.should be_false
      user_info.recently_online?.should be_true
      user_info.online_icon_name.should eq 'recently_online'
      user_info.update_attribute(:last_active_at, Time.new-16.minute)
      user_info.online?.should be_false
      user_info.recently_online?.should be_false
      user_info.online_icon_name.should eq 'offline'
    end
  end

end

require 'spec_helper'

describe SiteUserInformationsController do

  describe "GET 'show'" do
    before do
      @site_user_info= FactoryGirl.create(:site_user_information)
    end

    it "returns http success" do
      get :show, id: @site_user_info
      assigns(:site_user_information).should eql @site_user_info
      response.should be_success
      response.should render_template :show
    end
  end

  describe "GET 'edit'" do
    before do
      @site_user_info = FactoryGirl.create(:site_user_information)
    end

    it "returns http success" do
      get :edit, id: @site_user_info
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    before do
      @site_user_info = FactoryGirl.create(:site_user_information)
    end

    it "updates nick" do
      expect{
        put :update, id: @site_user_info, site_user_information: {nick: "Andyss"}
        }.not_to change(SiteUserInformation, :count)
      @site_user_info.reload
      @site_user_info.nick.should eql "Andyss"
    end

    it "updates name" do
      expect{
          put :update, id: @site_user_info, site_user_information: {name: "Rick"}
        }.not_to change(SiteUserInformation, :count)
      @site_user_info.reload
      @site_user_info.name.should eql "Rick"
    end

    it "updates surname" do
      expect{
          put :update, id: @site_user_info, site_user_information: {surname: "Ryder"}
        }.not_to change(SiteUserInformation, :count)
      @site_user_info.reload
      @site_user_info.surname.should eql "Ryder"
    end

    it "updates reputation" do
      expect{
        put :update, id: @site_user_info, site_user_information: {reputation: 12.0}
        }.not_to change(SiteUserInformation, :count)
      @site_user_info.reload
      @site_user_info.reputation.should eql 12.0
    end

    it "updates reputation 2" do
      expect{
        put :update, id: @site_user_info, site_user_information: {reputation: 122.0}
        }.not_to change(SiteUserInformation, :count)
      @site_user_info.reload
      @site_user_info.reputation.should_not eql 122.0
      expect{
        put :update, id: @site_user_info, site_user_information: {reputation: 100.0}
        }.not_to change(SiteUserInformation, :count)
      @site_user_info.reload
      @site_user_info.reputation.should eql 100.0
    end

    it "updates date of birth" do
      date = Date.new(2001,10,10)
      expect{
        put :update, id: @site_user_info, site_user_information: {date_of_birth: date}
        }.not_to change(SiteUserInformation, :count)
      @site_user_info.reload
      @site_user_info.date_of_birth.should eql date
    end

    it "doesnt updates date of birth" do
      date = Date.new(2011,10,10)
      expect{
        put :update, id: @site_user_info, site_user_information: {date_of_birth: date}
        }.not_to change(SiteUserInformation, :count)
      @site_user_info.reload
      @site_user_info.date_of_birth.should_not eql date
    end
  end

  describe "GET 'destroy'" do
    before do
      @site_user_info = FactoryGirl.create(:site_user_information)
    end

    it "returns http success" do
      delete :destroy, id: @site_user_info
      response.should be_success
    end
  end

end

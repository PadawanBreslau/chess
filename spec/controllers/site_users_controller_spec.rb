require 'spec_helper'

describe SiteUsersController do
  context "GET #index" do
    it "site users" do
      user = FactoryGirl.create(:site_user)
      get :index
      assigns(:site_users).to_a.should eql [user]
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

end

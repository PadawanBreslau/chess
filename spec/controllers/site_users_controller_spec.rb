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

  context "GET #show" do
    it "site users" do
      user = FactoryGirl.create(:site_user)
      get :show, id: user
      assigns(:site_user).should eql user
    end
  end

  context "GET #statistics" do
    it "site users" do
      user = FactoryGirl.create(:site_user)
      get :statistics
      assigns(:users_comments).to_a.should eql []
      assigns(:users_ratings).to_a.should eql []
    end

    it "renders the :index view" do
      get :statistics
      response.should render_template :statistics
    end
  end

end

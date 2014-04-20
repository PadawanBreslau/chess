# encoding: UTF-8

require 'spec_helper'

describe TournamentsController do

  context 'GET #show' do
    it "populates a tournament" do
      tournament = FactoryGirl.create(:tournament)
      get :show, id: tournament
      assigns(:tournament).should eql tournament
    end

    it "renders the :show view" do
      tournament = FactoryGirl.create(:tournament)
      get :show, id: tournament
      response.should render_template :show
    end
  end

  context 'GET :index' do
  end

  context 'POST #create' do
  end

end

# encoding: UTF-8
require 'spec_helper'

describe TournamentsController do

  context 'GET #show' do
    it 'populates a tournament' do
      tournament = FactoryGirl.create(:tournament)
      get :show, id: tournament
      assigns(:tournament).should eql tournament
    end

    it 'renders the :show view' do
      tournament = FactoryGirl.create(:tournament)
      get :show, id: tournament
      response.should render_template :show
    end
  end

  context 'GET :index' do
    it 'populates a tournament' do
      tournament = FactoryGirl.create(:tournament)
      get :index
      assigns(:tournaments).to_a.should eql [tournament]
    end

    it 'renders the :index view' do
      FactoryGirl.create(:tournament)
      get :index
      response.should render_template :index
    end
  end

  context 'GET :results' do
    it 'tournament results' do
      tournament = FactoryGirl.create(:tournament)
      get :results, id: tournament.id
      assigns(:tournament).should eql tournament
      assigns(:results_grid).should be_kind_of Wice::WiceGrid
    end
  end

  context 'GET :upload_games' do
    it 'should render upload_games' do
      tournament = FactoryGirl.create(:tournament)
      get :upload_games, id: tournament.id
      assigns(:tournament).should eql tournament
    end
  end


  context 'POST #create' do
    before do
      @tournament = FactoryGirl.build(:tournament)
    end

    it 'creates a new tournament' do
      expect{
          post :create, tournament: @tournament.attributes.symbolize_keys
        }.to change(Tournament,:count).from(0).to(1)
    end
  end

  context 'POST #import_games' do
    before do
      @tournament = FactoryGirl.create(:tournament)
    end

    it 'creates uploads pgn' do
      post :import_games, id: @tournament.id, tournament: {'pgn_file' => 'aaaaa'}
    end
  end

  context 'PUT #update' do
    before do
      @tournament = FactoryGirl.create(:tournament)
    end

    it 'updates a tournament' do
      expect{
        put :update, id: @tournament, tournament: {tournament_name: 'New tournament name'}
        }.not_to change(Tournament,:count).by(1)
      @tournament.reload
      @tournament.tournament_name.should eql 'New tournament name'
    end
  end

  context 'DELETE #tournament' do
    before do
      @tournament = FactoryGirl.create(:tournament)
    end

    it 'destroy a tournament' do
      expect{
        delete :destroy, id: @tournament
      }.to change(Tournament,:count).from(1).to(0)
    end
  end
end

# encoding: UTF-8
require 'spec_helper'

describe ChessGamesController do

  context 'GET #show' do
    it 'populates a games' do
      game = FactoryGirl.create(:chess_game_with_random_players)
      get :show, id: game
      assigns(:chess_game).should eql game
    end

    it 'renders the :show view' do
      game = FactoryGirl.create(:chess_game_with_random_players)
      get :show, id: game
      response.should render_template :show
    end
  end

  context 'GET :index' do
    it 'populates a game' do
      game = FactoryGirl.create(:chess_game_with_random_players)
      get :index
      assigns(:chess_games).to_a.should eql [game]
    end

    it 'renders the :index view' do
      FactoryGirl.create(:chess_game_with_random_players)
      get :index
      response.should render_template :index
    end
  end

  context 'POST #create' do
    before do
      @game = FactoryGirl.build(:chess_game_with_created_random_players)
    end

    it 'creates a new game' do
      pending "white_player_id is nil though white_player is not... WHY?"
      expect{
          post :create, chess_game: @game.attributes.symbolize_keys
        }.to change(ChessGame,:count).from(0).to(1)
    end
  end

  context 'PUT #update' do
    before do
      FactoryGirl.create(:chess_game)
    end

    it 'updates a game' do
      pending "white_player_id is nil though white_player is not... WHY?"
      expect{
        put :update, id: @game, chess_game: {result: 2}
        }.not_to change(ChessGame,:count).by(1)
      @game.reload
      @game.result.should eql 2
    end
  end

  context 'DELETE #game' do
    before do
      @game = FactoryGirl.create(:chess_game_with_random_players)
    end

    it 'destroy a game' do
      expect{
        delete :destroy, id: @game
        }.to change(ChessGame,:count).from(1).to(0)
    end
  end
end

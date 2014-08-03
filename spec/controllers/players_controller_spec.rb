require 'spec_helper'

describe PlayersController do

  describe "GET 'show'" do
    before do
      @player = FactoryGirl.create(:player_with_fide_id)
    end

    it "returns http success" do
      get :show, id: @player
      assigns(:player).should eql @player
    end
  end

  describe "GET 'index'" do
    before do
      @player = FactoryGirl.create(:player_with_fide_id)
    end
    it "returns http success" do
      get :index
      assigns(:players).to_a.should eql [@player]
    end
  end

  context 'POST #create' do
    before do
      @player = FactoryGirl.build(:player)
    end

    it 'creates a new site comment' do
      expect { post :create, player: @player.attributes.symbolize_keys
        }.to change(Player,:count).by(1)
    end
  end


  describe "GET 'edit'" do
    before do
      @player = FactoryGirl.create(:player_with_fide_id)
    end
    it "returns http success" do
      get :edit, id: @player
    end
  end

  describe "PUT 'update'" do
    before do
      @player = FactoryGirl.create(:player_with_fide_id)
    end

    it "updates name" do
      expect{
          put :update, id: @player, player: {name: "Rick"}
        }.not_to change(Player, :count)
      @player.reload
      @player.name.should eql "Rick"
    end

    it "updates surname" do
      expect{
          put :update, id: @player, player: {surname: "Ryder"}
        }.not_to change(Player, :count)
      @player.reload
      @player.surname.should eql "Ryder"
    end

  end

  describe "DELETE #delete" do
    before do
      @player = FactoryGirl.create(:player_with_fide_id)
    end

    it 'should delete article entry' do
       expect{
         delete :destroy, id: @player
         }.to change(Player,:count).by(-1)
    end

    it 'should redirect to index after destroy' do
      delete :destroy, id: @player
      response.should redirect_to players_url
    end
  end

  describe "GET 'statistics'" do
    before do
      @player = FactoryGirl.create(:player_with_fide_id)
    end

    it "returns http success" do
      get :statistics
      assigns(:players).to_a.should eql [@player]
      assigns(:prepared_ratings_hash).should be_blank
      assigns(:prepared_gamecount_hash).should be_blank
      assigns(:prepared_countries_hash).should be_blank
    end
  end

  describe "GET 'player_stats'" do
    before do
      @tournament = FactoryGirl.create(:tournament)
      @round = FactoryGirl.create(:round, tournament: @tournament, round_number: 1)
      @tournament.reload
      @player1 = FactoryGirl.create(:player, fide_id: 123, name: 'Andy')
      @player2 = FactoryGirl.create(:player, fide_id: 321, name: 'Bert')
      create_game(@player1, @player2, @round, 1 )
    end

    it "returns http success" do
      get :player_stats, id: @player1
      assigns(:player).should eql @player1
      assigns(:player_ratings).should be_blank
      assigns(:player_games_colors).inspect.should eql '{"white"=>1, "black"=>0}'
      assigns(:player_results_white).inspect.should eql '{"White wins"=>1}'
      assigns(:player_results_black).should be_blank
      assigns(:player_activities).should be_blank
    end

    it "returns http success-2" do
      get :player_stats, id: @player2
      assigns(:player).should eql @player2
      assigns(:player_ratings).should be_blank
      assigns(:player_games_colors).inspect.should eql '{"white"=>0, "black"=>1}'
      assigns(:player_results_black).inspect.should eql '{"Black loses"=>1}'
      assigns(:player_results_white).should be_blank
      assigns(:player_activities).should be_blank
    end
  end
end

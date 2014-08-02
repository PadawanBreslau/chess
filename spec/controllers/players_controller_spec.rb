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
end

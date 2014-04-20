# encoding: UTF-8
require 'spec_helper'

describe RoundsController do

  context 'GET #show' do
    it 'populates a rounds' do
      round = FactoryGirl.create(:round)
      get :show, id: round
      assigns(:round).should eql round
    end

    it 'renders the :show view' do
      round = FactoryGirl.create(:round)
      get :show, id: round
      response.should render_template :show
    end
  end

  context 'GET :index' do
    it 'populates a round' do
      round = FactoryGirl.create(:round)
      get :index
      assigns(:rounds).to_a.should eql [round]
    end

    it 'renders the :index view' do
      FactoryGirl.create(:round)
      get :index
      response.should render_template :index
    end
  end

  context 'POST #create' do
    before do
      @round = FactoryGirl.build(:round)
    end

    it 'creates a new round' do
      expect{
          post :create, round: @round.attributes.symbolize_keys
        }.to change(Round,:count).from(0).to(1)
    end
  end

  context 'PUT #update' do
    before do
      @round = FactoryGirl.create(:round, round_number: 1)
    end

    it 'updates a round' do
      expect{
        put :update, id: @round, round: {round_number: 9}
        }.not_to change(Round,:count).by(1)
      @round.reload
      @round.round_number.should eql 9
    end
  end

  context 'DELETE #round' do
    before do
      @round = FactoryGirl.create(:round)
    end

    it 'destroy a round' do
      expect{
        delete :destroy, id: @round
      }.to change(Round,:count).from(1).to(0)
    end
  end
end

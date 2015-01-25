require 'spec_helper'

describe Commentary do
  context 'creating commentary' do
    it 'should create commentary' do
      expect{FactoryGirl.build(:commentary)}.not_to raise_error
    end

    it 'should access site_user and move' do
      user = FactoryGirl.build(:site_user)
      move = FactoryGirl.build(:chess_move)
      comm = FactoryGirl.build(:commentary, chess_move: move, site_user: user)
      comm.chess_move.should eq move
      comm.site_user.should eq user
    end

    it 'commentary should be accessible from site_user and move' do
      user = FactoryGirl.create(:site_user)
      move = FactoryGirl.create(:chess_move, move_notation: 'e2-e4')
      comm = FactoryGirl.create(:commentary, chess_move: move, site_user: user)
      user.commentaries.should eq [comm]
      move.commentaries.should eq [comm]
    end
  end
end

class PlayersController < ApplicationController
  load_and_authorize_resource param_method: :player_params
  def show
    @player = Player.find(params[:id])
    @title = @player.to_title
  end

  def index
    @players = Player.page(params[:page])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to player_path(@player)
    else
      redirect_to new_player_path
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    @player.update_attributes(player_params)
    if @player.save
      redirect_to player_path(@player)
    else
      redirect_to :back
    end
  end

  def destroy
    @player = Player.find(params[:id]).destroy
    redirect_to players_path
  end

  private

  def player_params
    params.require(:player).permit(:name, :surname, :middlename, :fide_id, :date_of_birth, :site_user, :player_photo)
  end
end

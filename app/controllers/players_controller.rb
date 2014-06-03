class PlayersController < ApplicationController
  load_and_authorize_resource param_method: :player_params
  def show
    @player = Player.find(params[:id])
  end

  def index
    @players_grid = initialize_grid(Player)
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

  def statistics
    @players = Player.all
    @prepared_international_title_hash = Statistic.find_by_name("players_titles").to_hash
    @prepared_ratings_hash = Statistic.find_by_name("players_ratings").to_hash
    @prepared_gamecount_hash = Statistic.find_by_name("games_number").to_hash
    @prepared_countries_hash = Statistic.find_by_name("players_countries").to_hash
  end

  def player_stats
    @player = Player.find(params[:id])
    @player_ratings = @player.get_player_ratings
    @player_games_colors = @player.get_player_colors
    @player_results_white = @player.get_player_results('white')
    @player_results_black = @player.get_player_results('black')
    @player_activities = @player.get_player_activities  # FIDE RATING - games per period
  end

  private

  def player_params
    params.require(:player).permit(:name, :surname, :middlename, :fide_id, :date_of_birth, :site_user, :player_photo)
  end
end

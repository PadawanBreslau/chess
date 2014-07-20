class ChessGamesController < InheritedResources::Base
  load_and_authorize_resource param_method: :permitted_params

  actions :all, except: []
  FIELDS = [:date, :white_player_id, :black_player_id,
    :result, :eco, :round_id]

  def index
    if params[:round_id]
      @games = ChessGame.where(round_id: params[:round_id])
    else
      super
    end
  end

  def permitted_params
    params.permit(game: [FIELDS])
  end

end

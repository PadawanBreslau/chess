class GamesController < InheritedResources::Base
  actions :all, except: []
  FIELDS = [:date, :white_player_id, :black_player_id,
    :result, :eco, :round_id]

  def permitted_params
    params.permit(game: [FIELDS])
  end

end

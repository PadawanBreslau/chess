class RoundsController < InheritedResources::Base
  load_and_authorize_resource param_method: :permitted_params

  actions :all, except: []
  FIELDS = [:date, :round_number]

  def index
    if params["tournament_id"]
      @rounds_grid = initialize_grid(Round, conditions: {tournament_id: params["tournament_id"]}, order: 'rounds.round_number', order_direction: 'asc')
    else
      @rounds_grid = initialize_grid(Round, order: 'rounds.date', order_direction: 'desc')
    end
  end

  def permitted_params
    params.permit(round: [FIELDS])
  end
end

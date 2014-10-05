class TournamentsController < InheritedResources::Base
  load_and_authorize_resource param_method: :permitted_params
  actions :all, except: []
  FIELDS = [:tournament_name, :tournament_start, :tournament_finish, :round_number, :is_finished, :place, :url, :external_transmition_url, :event_id]

  def index
    @tournaments_grid = initialize_grid(Tournament)
  end

  def show
    @tournament = Tournament.find(params["id"])
    @rounds = @tournament.rounds
    @rounds_grid = initialize_grid(Round, conditions: {tournament_id: @tournament.id}, order: 'rounds.round_number', order_direction: 'asc')
    @results_grid = initialize_grid(@tournament.results(1000), per_page: 100)
  end

  def results
    @tournament = Tournament.find(params[:id])
    @results_grid = initialize_grid(@tournament.results(1000), per_page: 100)
  end

  def upload_games
    @tournament = Tournament.find(params[:id])
  end

  def import_games
    @tournament = Tournament.find(params[:id])
    pgn_file = params["tournament"]["pgn_file"]
    begin
      @tournament.parse_and_insert_from_pgn(pgn_file)
    rescue StandardError => e
      ER_LOG.info e.message
      ER_LOG.info e.backtrace
    end
    redirect_to @tournament
  end



  def permitted_params
    params.permit(tournament: FIELDS)
  end
end

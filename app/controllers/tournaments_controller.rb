class TournamentsController < InheritedResources::Base
  load_and_authorize_resource param_method: :permitted_params
  actions :all, except: []
  FIELDS = [:tournament_name, :tournament_start, :tournament_finish, :round_number, :is_finished, :place, :url, :external_transmition_url, :event_id]

  def permitted_params
    params.permit(tournament: FIELDS)
  end
end

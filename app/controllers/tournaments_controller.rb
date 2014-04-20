class TournamentsController < InheritedResources::Base
  actions :all, except: []
  FIELDS = [:tournament_name, :tournament_start, :tournament_finish, :round_number, :is_finished, :place, :url, :external_transmition_url]

  def permitted_params
    params.permit(tournament: FIELDS)
  end
end

class EventsController < InheritedResources::Base
  load_and_authorize_resource param_method: :permitted_params
  actions :all, except: []
  FIELDS = [:event_name, :url, :event_start, :event_finish, :description]

  def index
    @events_grid = initialize_grid(Event)
  end


  def permitted_params
    params.permit(event: FIELDS)
  end
end

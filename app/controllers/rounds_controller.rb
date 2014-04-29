class RoundsController < InheritedResources::Base
  load_and_authorize_resource param_method: :permitted_params

  actions :all, except: []
  FIELDS = [:date, :round_number]

  def permitted_params
    params.permit(round: [FIELDS])
  end
end

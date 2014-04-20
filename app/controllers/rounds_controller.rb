class RoundsController < InheritedResources::Base
  actions :all, except: []
  FIELDS = [:date, :round_number]

  def permitted_params
    params.permit(round: [FIELDS])
  end
end

class TournamentsController < InheritedResources::Base
  actions :all, except: []

  def permitted_params
    params.permit(:tournament => [:permitted_field, :other_permitted_field])
  end
end

class SiteUsersController < ApplicationController
  load_and_authorize_resource

  def index
    @site_users_grid = initialize_grid(SiteUserInformation)
  end

  def show
    @site_user = SiteUser.find(params[:id])
  end

end

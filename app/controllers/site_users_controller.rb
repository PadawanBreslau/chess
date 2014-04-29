class SiteUsersController < ApplicationController
  load_and_authorize_resource

  def index
    @site_users = SiteUser.page(params[:page])
  end

  def show
    @site_user = SiteUser.find(params[:id])
  end

end

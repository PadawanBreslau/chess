class SiteUsersController < ApplicationController

  def index
    @site_users = SiteUser.page(params[:page])
  end

end

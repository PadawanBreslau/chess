class SiteUsersController < ApplicationController
  load_and_authorize_resource

  def index
    @site_users_grid = initialize_grid(SiteUserInformation)
  end

  def show
    @site_user = SiteUser.find(params[:id])
  end

  def statistics
    @users_comments = SiteUser.get_users_comments
    @users_ratings = SiteUser.get_user_ratings
    @users_birthdays = SiteUser.get_user_birthdays
    @users_reputation = SiteUser.get_user_reputation
    @users_recent_activity = SiteUser.get_recent_activities
  end

  def user_stats
  end

end

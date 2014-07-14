class SiteUsersController < ApplicationController
  load_and_authorize_resource

  def index
    @site_users_grid = initialize_grid(SiteUserInformation)
  end

  def show
    @site_user = SiteUser.find(params[:id])
  end

  def statistics
    @users_comments = Statistic.find_by_name("users_comments").to_hash
    @users_ratings = Statistic.find_by_name("users_ratings").to_hash
    @users_birthdays = Statistic.find_by_name("users_birthdays").to_hash
    @users_reputation = Statistic.find_by_name("users_reputations").to_hash
    @user_countries = Statistic.find_by_name("users_countries").to_hash
    #@users_recent_activity = Statistic.find_by_name("users_activities").to_hash
  end

  def user_stats
  end

end

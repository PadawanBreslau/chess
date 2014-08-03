class SiteUsersController < ApplicationController
  load_and_authorize_resource

  def index
    @site_users_grid = initialize_grid(SiteUserInformation)
  end

  def show
    @site_user = SiteUser.find(params[:id])
  end

  def statistics
    @users_comments = Statistic.find_by_name("users_comments").try(:to_hash)
    @users_ratings = Statistic.find_by_name("users_ratings").try(:to_hash)
    @users_birthdays = Statistic.find_by_name("users_birthdays").try(:to_hash)
    @users_reputation = Statistic.find_by_name("users_reputations").try(:to_hash)
    @user_countries = Statistic.find_by_name("users_countries").try(:to_hash)
    @users_recent_activity = Statistic.find_by_name("users_activities").try(:to_hash)
  end

  def user_stats
  end

end

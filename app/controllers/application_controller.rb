# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :record_user_activity
  #check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_user
    current_site_user
  end

  private

  def record_user_activity
    if current_user && current_user.site_user_information
      current_user.site_user_information.touch :last_active_at
    end
  end
end

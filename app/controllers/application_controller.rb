# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :record_user_activity

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

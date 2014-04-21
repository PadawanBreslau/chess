# -*- encoding : utf-8 -*-
module ApplicationHelper

  def current_user
    current_site_user
  end

  def to_created_at(object)
    fail unless object.respond_to?(:created_at)
    object.created_at.strftime('%d-%m-%Y/%H:%M')
  rescue
    raise ArgumentError "Invalid call to created_at"
  end

  def to_updated_at(object)
    fail unless object.respond_to?(:updated_at)
    object.updated_at.strftime('%d-%m-%Y/%H:%M')
  rescue
    raise ArgumentError "Invalid call to updated_at"
  end

  def short_created_at(object)
    fail unless object.respond_to?(:created_at)
    object.created_at.strftime('%H:%M')
  rescue
    raise ArgumentError "Invalid call to created_at"
  end

  def short_updated_at(object)
    fail unless object.respond_to?(:updated_at)
    object.updated_at.strftime('%H:%M')
  rescue
    raise ArgumentError "Invalid call to updated_at"
  end

end

# -*- encoding : utf-8 -*-
module ApplicationHelper

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

end

class Commentary < ActiveRecord::Base
  attr_accessor :type, :comment

  belongs_to :site_user
  belongs_to :chess_move

end

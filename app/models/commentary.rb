class Commentary < ActiveRecord::Base

  belongs_to :site_user
  belongs_to :chess_move

end

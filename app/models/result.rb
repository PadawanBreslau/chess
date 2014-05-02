class Result < ActiveRecord::Base
  default_scope -> { order_by(points:  :desc) }

  belongs_to :player
  belongs_to :tournament
end

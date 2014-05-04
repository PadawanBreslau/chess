class Result < ActiveRecord::Base
  default_scope -> { order(points:  :desc) }
  scope :tournament, ->(tournament, lmt) { where(tournament_id: tournament.id).limit(lmt) }

  belongs_to :player
  belongs_to :tournament
end

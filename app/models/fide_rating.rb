class FideRating < ActiveRecord::Base

  attr_accessor :fide_id, :year, :month, :rating

  validates :fide_id, numericality: true, presence: true
  validates :year, numericality: true, presence: true, inclusion: 1950..Time.now.year
  validates :month, numericality: true, presence: true,  inclusion: 1..12
  validates :rating, numericality: true, presence: true, inclusion: 1000..3500

end

class Player < ActiveRecord::Base

	attr_accessor :name, :surname, :middlename, :fide_id

	NAME_REGEX = /\A[\s[:alpha:]-]*\z/u

	validates :name, presence: true, format: { with: NAME_REGEX }, length: {minimum: 2, maximum: 32}
	validates :middlename, format: { with: NAME_REGEX }, length: {minimum: 2, maximum: 32}, allow_nil: true
	validates :surname, presence: true, format: { with: NAME_REGEX }, length: {minimum: 2, maximum: 32}



end
class SiteUserInformation < ActiveRecord::Base

has_one :site_user
validates :name, allow_blank: true, length: {minimum: 1, maximum: 24}
validates :surname, allow_blank: true, length: {minimum: 1, maximum: 24}
validates :nick, allow_blank: true, length: {minimum: 1, maximum: 24}
validates :reputation, allow_blank: true, numericality: {greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100.0}
validate :date_of_birth_validation, if: Proc.new{|info| info.date_of_birth.present?}


def to_title
  "FAKE NAME"
  #TODO
end

private

def date_of_birth_validation
  errors.add(:date_of_birth, "Invalid date of birth") if date_of_birth > Date.today-5.years
end




end

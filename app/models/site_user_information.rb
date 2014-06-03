class SiteUserInformation < ActiveRecord::Base
  has_one :site_user
  validates :name, allow_blank: true, length: {minimum: 1, maximum: 24}
  validates :surname, allow_blank: true, length: {minimum: 1, maximum: 24}
  validates :nick, allow_blank: true, length: {minimum: 1, maximum: 24}
  validates :reputation, allow_blank: true, numericality: {greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100.0}
  validate :date_of_birth_validation, if: Proc.new{|info| info.date_of_birth.present?}
  validates :rating, allow_blank: true, numericality: {greater_than_or_equal_to: 1000.0, less_than_or_equal_to: 3300.0}
  validates :about_me, allow_blank: true, length: {minimum: 1, maximum: 256}

  def fullname
    "#{name} #{surname}"
  end

  def nickname
    nick || site_user.email
  end

  def is_initialized?
    name.present? || surname.present? || nick.present? || date_of_birth.present? || rating.present?
  end

  def online?
    last_active_at && last_active_at > 120.seconds.ago
  end

  def recently_online?
    last_active_at && last_active_at > 15.minutes.ago && !online?
  end

  def online_icon_name
    if online?
      "online"
    elsif recently_online?
      "recently_offline"
    else
      "offline"
    end
  end

  def country
    return nil unless country_code
    country = ISO3166::Country[country_code]
    country.names[0] || country.name
  end


private

def date_of_birth_validation
  errors.add(:date_of_birth, "Invalid date of birth") if date_of_birth > Date.today-5.years || date_of_birth < Date.today - 110.years
end




end

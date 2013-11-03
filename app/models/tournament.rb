class Tournament < ActiveRecord::Base

NAME_REGEX = /[a-zA-Z\s]+/
URL_REGEX = /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix

has_many :rounds
has_many :games, through: :rounds
belongs_to :event

validates :tournament_name, presence: true, length: {minimum: 2, maximum: 128}, uniqueness: true
validates :round_number, numericality: true, inclusion: (1..999), allow_nil: true
validates :place, format: { with: NAME_REGEX }, allow_nil: true
validates :url, format: { with: URL_REGEX }, allow_nil: true
validates :external_transmition_url, format: { with: URL_REGEX }, allow_nil: true

validate :check_if_start_is_before_finish

after_save :create_rounds


def players
  self.white_players.concat(self.black_players)
end


private

  def create_rounds
    return false if rounds.present?
    if round_number
      round_number.times do |i|
        if (tournament_finish - tournament_start) == round_number-1
          rounds << Round.create!(round_number: i+1, date: tournament_start + i.days)
        else
          rounds << Round.create!(round_number: i+1, date: tournament_start)
        end
      end
    end
  rescue Exception => e
    errors.add(:rounds, "can't add rounds")
    #flash[:error] = t('error.tournament.unable_to_create_rounds')
  end

  def check_if_start_is_before_finish
    if tournament_start > tournament_finish
      errors.add(:finish_date, "can't be before start date")
    end
  end
end

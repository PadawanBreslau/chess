class Event < ActiveRecord::Base

has_many :tournaments
has_many :rounds, through: :tournaments
has_many :games, through: :tournaments

URL_REGEX = /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix

validates :event_name, presence: true, length: {minimum: 2, maximum: 128}, uniqueness: true
validates :url, format: { with: URL_REGEX }, allow_nil: true

end

class Article < ActiveRecord::Base

belongs_to :site_user
belongs_to :commentable
has_many :article_photos
has_many :site_comments, as: :commentable

validates :title, presence: true, length: {minimum: 4, maximum: 128}
validates :lead, allow_blank: true, length: {minimum: 16, maximum: 128}
validates :summary, allow_blank: true, length: {minimum: 16, maximum: 2048}
validates :content, presence: true, length: {minimum: 16, maximum: 2**15}

end
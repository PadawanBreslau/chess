class Article < ActiveRecord::Base

acts_as_taggable
paginates_per 5

belongs_to :site_user
belongs_to :commentable
has_many :article_photos
has_many :site_comments, as: :commentable, dependent: :destroy
has_one :rate, as: :rateable, dependent: :destroy

validates :title, presence: true, length: {minimum: 4, maximum: 128}
validates :lead, allow_blank: true, length: {minimum: 16, maximum: 128}
validates :summary, allow_blank: true, length: {minimum: 16, maximum: 2048}
validates :content, presence: true, length: {minimum: 16, maximum: 2**15}

after_create :create_rating

  def author
    site_user.nickname
  end

private

  def create_rating
    Rate.create!(:rateable_id => self.id, :rateable_type => self.class.name)
  end

end

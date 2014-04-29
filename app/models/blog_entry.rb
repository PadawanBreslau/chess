class BlogEntry < ActiveRecord::Base
acts_as_taggable
paginates_per 10

belongs_to :site_user
belongs_to :commentable
has_many :blog_entry_photos
has_many :site_comments, as: :commentable
has_one :rate, as: :rateable, dependent: :destroy

validates :title, presence: true, length: {minimum: 4, maximum: 128}
validates :content, presence: true, length: {minimum: 16, maximum: 2**12}
#validates :site_user, presence: true

after_create :create_rating


  def author
    site_user.nickname
  end

private

  def create_rating
    Rate.create!(:rateable_id => self.id, :rateable_type => self.class.name)
  end

end

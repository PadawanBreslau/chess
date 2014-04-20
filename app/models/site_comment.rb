class SiteComment < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true
  belongs_to :site_user
  has_one :rate, :as => :rateable, dependent: :destroy

  default_scope  {order('created_at DESC')}
  scope :last_comments, lambda{ |user_id, lmt| where(site_user_id: user_id).limit(lmt) unless user_id.nil? }

  validates :content, presence: true, on: :create, length: { minimum: 1 , maximum: 1024}
  validates :site_user, presence: true, on: :create

  after_create :create_rating

private

  def create_rating
    Rate.create!(:rateable_id => self.id, :rateable_type => self.class.name)
  end
end

class SiteUsersRate < ActiveRecord::Base
  belongs_to :site_user
  belongs_to :rate

  validates :site_user_id, :uniqueness => {:scope => :rate_id}   
  
  def self.find_or_create(attributes)
    SiteUsersRate.where(attributes).first || SiteUsersRate.create(attributes)
  end
end

class SiteUser < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :site_user_information
  has_many :articles
  has_many :blog_entries
  has_many :site_comments

  has_many :rates, :through => :site_users_rates
  has_many :site_users_rates

  delegate :reputation, to: :site_user_information
  delegate :reputation=, to: :site_user_information

  after_create :create_site_user_information

  private

  def create_site_user_information
  	SiteUserInformation.create!(site_user: self, reputation: 0.0)
  end

end

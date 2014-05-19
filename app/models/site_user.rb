class SiteUser < ActiveRecord::Base
  include UserHelper
  ROLES = %w[admin moderator player common_user suspended banned]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :site_user_information
  has_many :articles
  has_many :blog_entries
  has_many :site_comments

  has_many :rates, :through => :site_users_rates
  has_many :site_users_rates

  delegate :name, to: :site_user_information
  delegate :surname, to: :site_user_information
  delegate :nick, to: :site_user_information
  delegate :date_of_birth, to: :site_user_information
  delegate :country, to: :site_user_information
  delegate :rating, to: :site_user_information
  delegate :reputation, to: :site_user_information
  delegate :reputation=, to: :site_user_information
  delegate :nick, to: :site_user_information
  delegate :about_me, to: :site_user_information
  delegate :last_active_at, to: :site_user_information
  delegate :nickname, to: :site_user_information
  delegate :online_icon_name, to: :site_user_information

  after_create :create_site_user_information

  validate :role, inclusion: { in: ROLES }, allow_blank: true

  private

  def create_site_user_information
  	SiteUserInformation.create!(site_user: self, reputation: 0.0)
  end

end

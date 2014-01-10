class SiteUser < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :site_user_information
  has_many :articles
  has_many :blog_entries
end

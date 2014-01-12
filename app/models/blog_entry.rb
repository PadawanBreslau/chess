class BlogEntry < ActiveRecord::Base
acts_as_taggable
belongs_to :site_user
belongs_to :commentable
has_many :blog_entry_photos
has_many :site_comments, as: :commentable

validates :title, presence: true, length: {minimum: 4, maximum: 128}
validates :content, presence: true, length: {minimum: 16, maximum: 2**12}

end

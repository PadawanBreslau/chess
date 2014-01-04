class ArticlePhoto < ActiveRecord::Base

  belongs_to :article
  has_attached_file :photo, :styles => { :big => "800x800>", :medium => "400x400>", :thumb => "80x80>" }, :default_url => "/images/:style/example_photo.png"

  validates :photo, presence: true, attachment_content_type: { content_type: ["image/jpg","image/png"]}, attachment_size: { in: 0..3.megabytes }

end

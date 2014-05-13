class ArticlePhoto < ActiveRecord::Base

  belongs_to :article
  has_attached_file :photo, styles: { big: "800x800>", medium: "400x400>", thumb: "80x80>" }, default_url: "/images/:style/example_photo.png", url: "/assets/photos/:id/:style/:basename.:extension", path: ":rails_root/public/assets/article_photos/:id/:style/:basename.:extension"

  validates :photo, presence: true, attachment_content_type: { content_type: ["image/jpg","image/png"]}, attachment_size: { in: 0..3.megabytes }
  validates :article, presence: true
end

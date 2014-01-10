class BlogEntryPhoto < ActiveRecord::Base

  belongs_to :blog_entry
  has_attached_file :photo, :styles => { :big => "500x500>", :medium => "240x240>", :thumb => "80x80>" }, :default_url => "/images/:style/example_photo.png",                   :url  => "/assets/photos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/blog_photos/:id/:style/:basename.:extension"

  validates :photo, presence: true, attachment_content_type: { content_type: ["image/jpg","image/png"]}, attachment_size: { in: 0..3.megabytes }
  validates :blog_entry, presence: true
end

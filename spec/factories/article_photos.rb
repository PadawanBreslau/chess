# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article_photo do
    photo_file_name 'article_photo.png'
    photo_content_type 'image/png'
    photo_file_size 1024
    association :article
  end
end

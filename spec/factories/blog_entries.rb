# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_entry do
    association :site_user, strategy: :build
    title "BlogTitle"
    content "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    factory :blog_entry_with_one_photo do
      after(:create) do |blog_entry, _|
        FactoryGirl.create(:blog_entry_photo, :blog_entry => blog_entry)
      end
    end

    factory :blog_entry_with_photos do
      after(:create) do |blog_entry, _|
        5.times do
          FactoryGirl.create(:blog_entry_photo, :blog_entry => blog_entry)
        end
      end
    end
  end
end

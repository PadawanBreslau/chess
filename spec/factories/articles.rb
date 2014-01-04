# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    association :site_user, strategy: :build
    title "Title"
    lead "Lead is placed here"
    summary "Summary of an article that I'll write"
    content "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    factory :article_with_one_photo do
      after(:create) do |article, _|
        FactoryGirl.create(:article_photo, :article => article)
      end
    end

    factory :article_with_photos do
      after(:create) do |article, _|
        5.times do
          FactoryGirl.create(:article_photo, :article => article)
        end
      end
    end

  end
end

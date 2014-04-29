FactoryGirl.define do
  factory :site_user do
    email                 "user#{SecureRandom.hex(10)}@chess.com"
    password              "password"
    password_confirmation "password"
    role                  "admin"
  end
end

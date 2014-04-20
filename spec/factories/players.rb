# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory  :player do
    name "Alan"
    surname Array.new(8){[ *'a'..'z'].sample}.join
    middlename "Culkin"

    factory :player_with_date_of_birth do
      date_of_birth { Date.today - 25.years }
    end

    factory :player_with_fide_id do
      fide_id SecureRandom.random_number(999999999)
    end

    factory :player_with_photo do
      photo_file_name 'photo.png'
      photo_content_type 'image/png'
      photo_file_size 1024
    end

  end
end

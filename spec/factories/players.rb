# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory  :player do
    name "Alan"
    surname "Beowulf"
    middlename "Culkin"
      
    factory :player_with_date_of_birth do
      date_of_birth { Date.today - 25.years }
    end

    factory :player_with_fide_id do
      fide_id 111333111
    end	
  end  
end

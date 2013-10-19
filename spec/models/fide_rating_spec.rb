require 'spec_helper'

describe FideRating do
  context 'creating single fide rating record' do

     it 'should create simple fide ratig object' do
       FactoryGirl.build(:fide_rating).should be_valid
     end

     it 'should not allow FIDE rating with improper data' do
       FactoryGirl.build(:fide_rating, rating: 999).should_not be_valid
       FactoryGirl.build(:fide_rating, year: 1900).should_not be_valid
       FactoryGirl.build(:fide_rating, month: 13).should_not be_valid
       FactoryGirl.build(:fide_rating, fide_id: "XXX").should_not be_valid
     end

  end
end

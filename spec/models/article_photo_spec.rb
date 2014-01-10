require 'spec_helper'

describe ArticlePhoto do
  context 'creating article photo' do
    it 'should create article photo' do
      FactoryGirl.build(:article_photo).should be_valid
      expect{FactoryGirl.create(:article_photo)}.not_to raise_error
      expect{FactoryGirl.create(:article_photo, photo_file_name: nil)}.to raise_error
      expect{FactoryGirl.create(:article_photo, photo_content_type: 'image/gif')}.to raise_error
      expect{FactoryGirl.create(:article_photo, photo_file_size: -1)}.to raise_error
    end

    it 'should not create article photo without article' do
      expect{FactoryGirl.create(:article_photo, article: nil)}.to raise_error
    end
  end
end

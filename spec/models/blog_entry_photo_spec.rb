require 'spec_helper'

describe BlogEntryPhoto do
  context 'creating blog_entry photo' do
    it 'should create blog_entry photo' do
      FactoryGirl.build(:blog_entry_photo).should be_valid
      expect{FactoryGirl.create(:blog_entry_photo)}.not_to raise_error
      expect{FactoryGirl.create(:blog_entry_photo, photo_file_name: nil)}.to raise_error
      expect{FactoryGirl.create(:blog_entry_photo, photo_content_type: 'image/gif')}.to raise_error
      expect{FactoryGirl.create(:blog_entry_photo, photo_file_size: -1)}.to raise_error
    end

    it 'should not create blog_entry photo without blog_entry' do
      expect{FactoryGirl.create(:blog_entry_photo, blog_entry: nil)}.to raise_error
    end
  end
end

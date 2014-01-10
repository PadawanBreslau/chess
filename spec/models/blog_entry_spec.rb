require 'spec_helper'

describe BlogEntry do
  context 'Creating blog_entrys' do
    it 'should create simple blog_entry' do
      FactoryGirl.build(:blog_entry).should be_valid
      expect{@blog_entry = FactoryGirl.create(:blog_entry)}.not_to raise_error
      @blog_entry.site_user.should_not be_nil
      @blog_entry.site_user.blog_entries.first.should eql @blog_entry
    end

    it 'should not create simple blog_entry without content and title' do
      FactoryGirl.build(:blog_entry, title: nil).should_not be_valid
      FactoryGirl.build(:blog_entry, content: nil).should_not be_valid
    end

    it 'data should have proper length - title' do
      FactoryGirl.build(:blog_entry, title: 'a').should_not be_valid
      FactoryGirl.build(:blog_entry, title: 'aaa').should_not be_valid
      FactoryGirl.build(:blog_entry, title: 'aaaa').should be_valid
      FactoryGirl.build(:blog_entry, title: 'a'*128).should be_valid
      FactoryGirl.build(:blog_entry, title: 'a'*129).should_not be_valid
    end

    it 'data should have proper length - content' do
      FactoryGirl.build(:blog_entry, content: 'a').should_not be_valid
      FactoryGirl.build(:blog_entry, content: 'a'*15).should_not be_valid
      FactoryGirl.build(:blog_entry, content: 'a'*16).should be_valid
      FactoryGirl.build(:blog_entry, content: 'a'*2**12).should be_valid
      FactoryGirl.build(:blog_entry, content: 'a'*(2**12+1)).should_not be_valid
    end
  end

end

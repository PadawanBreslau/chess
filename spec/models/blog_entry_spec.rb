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

  context 'tags' do
    before do
      @blog_entry = FactoryGirl.create(:blog_entry)
    end

    it 'should be able to add tags to blog_entry' do
      @blog_entry.tag_list.should be_blank
      @blog_entry.tag_list.add("chess", "game")
      @blog_entry.tag_list.should_not be_blank
      @blog_entry.tag_list.should eql ["chess", "game"]
      @blog_entry.save
      @blog_entry.reload
      @blog_entry.tags.size.should eql 2
    end

    it 'should be able to remove tags' do
      @blog_entry.tag_list.add("chess", "game")
      @blog_entry.tag_list.should eql ["chess", "game"]
      @blog_entry.tag_list.remove("chess", "game")
      @blog_entry.save
      @blog_entry.reload
      @blog_entry.tags.size.should eql 0
    end

    it 'should find blog_entrys with specified tags' do
      @blog_entry.tag_list.add("chesstag", "game")
      @blog_entry.save
      @blog_entry.reload
      BlogEntry.tagged_with("chesstag").size.should eql 1
      BlogEntry.tagged_with(["chesstag", "game"]).size.should eql 1
      BlogEntry.tagged_with(["chesstag", "chessgame"]).size.should eql 0
    end

    it 'should find related blog entries' do
      @blog_entry2 = FactoryGirl.create(:blog_entry)
      @blog_entry.tag_list.add("chess", "game")
      @blog_entry2.tag_list.add("chess", "chesssgame")
      @blog_entry.save
      @blog_entry2.save
      @blog_entry.reload
      @blog_entry2.reload
      @blog_entry.find_related_tags.to_a.first.should eql @blog_entry2
    end
  end
end

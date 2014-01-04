require 'spec_helper'

describe Article do
  context 'Creating articles' do
    it 'should create simple article' do
      FactoryGirl.build(:article).should be_valid
      expect{@article = FactoryGirl.create(:article)}.not_to raise_error
      @article.site_user.should_not be_nil
      @article.site_user.articles.first.should eql @article
    end

    it 'should create simple article without lead and summary but not without content and title' do
      FactoryGirl.build(:article, lead: nil, summary: nil).should be_valid
      FactoryGirl.build(:article, title: nil).should_not be_valid
      FactoryGirl.build(:article, content: nil).should_not be_valid
    end

    it 'data should have proper length - title' do
      FactoryGirl.build(:article, title: 'a').should_not be_valid
      FactoryGirl.build(:article, title: 'aaa').should_not be_valid
      FactoryGirl.build(:article, title: 'aaaa').should be_valid
      FactoryGirl.build(:article, title: 'a'*128).should be_valid
      FactoryGirl.build(:article, title: 'a'*129).should_not be_valid
    end

    it 'data should have proper length - lead' do
      FactoryGirl.build(:article, lead: 'a').should_not be_valid
      FactoryGirl.build(:article, lead: 'aaa').should_not be_valid
      FactoryGirl.build(:article, lead: 'aaaa').should_not be_valid
      FactoryGirl.build(:article, lead: 'a'*15).should_not be_valid
      FactoryGirl.build(:article, lead: 'a'*16).should be_valid
      FactoryGirl.build(:article, lead: 'a'*128).should be_valid
      FactoryGirl.build(:article, lead: 'a'*129).should_not be_valid
    end

    it 'data should have proper length - summary' do
      FactoryGirl.build(:article, summary: 'a').should_not be_valid
      FactoryGirl.build(:article, summary: 'a'*15).should_not be_valid
      FactoryGirl.build(:article, summary: 'a'*16).should be_valid
      FactoryGirl.build(:article, summary: 'a'*2048).should be_valid
      FactoryGirl.build(:article, summary: 'a'*2049).should_not be_valid
    end

    it 'data should have proper length - content' do
      FactoryGirl.build(:article, content: 'a').should_not be_valid
      FactoryGirl.build(:article, content: 'a'*15).should_not be_valid
      FactoryGirl.build(:article, content: 'a'*16).should be_valid
      FactoryGirl.build(:article, content: 'a'*2**15).should be_valid
      FactoryGirl.build(:article, content: 'a'*(2**15+1)).should_not be_valid
    end
  end

  context 'article photos' do
    it 'should create simple article with photo' do
      FactoryGirl.build(:article_with_one_photo).should be_valid
      expect{@article = FactoryGirl.create(:article_with_one_photo)}.not_to raise_error
      @article.article_photos.should_not be_empty
      @article.article_photos.size.should eql 1
    end

    it 'should create simple article with photo' do
      FactoryGirl.build(:article_with_photos).should be_valid
      expect{@article = FactoryGirl.create(:article_with_photos)}.not_to raise_error
      @article.article_photos.should_not be_empty
      @article.article_photos.size.should eql 5
    end
  end

  context 'article comments' do
    before do
      @site_user = FactoryGirl.create(:site_user)
      @article = FactoryGirl.create(:article, site_user: @site_user)
    end

    it 'should create simpe article without comment' do
      @article.site_comments.should be_empty
      comment = FactoryGirl.build(:site_comment, site_user: @site_user)
      @article.site_comments << comment
      @article.site_comments.should_not be_empty
    end

    it 'should be able to add more comments to one artile' do
      @article.site_comments.should be_empty
      10.times do
        comment = FactoryGirl.build(:site_comment, site_user: @site_user)
        @article.site_comments << comment
      end
      @article.site_comments.should_not be_empty
      @article.site_comments.size.should eql 10
    end

    it 'should display comments in good order' do
      @article.site_comments.should be_empty
      comment = FactoryGirl.create(:site_comment, site_user: @site_user)
      sleep 1.seconds
      comment2 = FactoryGirl.create(:site_comment, site_user: @site_user)
      @article.site_comments << comment
      @article.site_comments << comment2
      @article.site_comments.size.should eql 2
      @article.site_comments.first.should eql comment2
      @article.site_comments.last.should eql comment
    end
  end
end

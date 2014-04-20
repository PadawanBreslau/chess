require 'spec_helper'

describe Rate do
  context 'article rates' do
    before do
      @site_user = FactoryGirl.create(:site_user, email: "ratings@chess.chess")
      @site_user.reputation = 1.0
      @article = FactoryGirl.create(:article)
    end

    it 'should create rate after creating article' do
      @article.rate.should_not be_nil
      @article.rate.likes.should eql 0
      @article.rate.dislikes.should eql 0
      @article.rate.general_rate.should eql 0.0
      @article.rate.site_users.should be_empty
    end

    it 'should be able to like an article' do
      rate = @article.rate
      rate.like(@site_user)
      rate.likes.should eql 1
      rate.dislikes.should eql 0
      rate.general_rate.should eql 1.0
      rate.site_users.should_not be_empty
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should be able to revert a like' do
      rate = @article.rate
      rate.like(@site_user)
      rate.likes.should eql 1
      rate.dislikes.should eql 0
      rate.general_rate.should eql 1.0

      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]

      rate.dislike(@site_user, true)
      rate.likes.should eql 0
      rate.dislikes.should eql 1
      rate.general_rate.should eql -1.0

      #changing like to dislike should not change number of users ratings
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should be able to dislike an article' do
      rate = @article.rate
      rate.dislike(@site_user)
      rate.likes.should eql 0
      rate.dislikes.should eql 1
      rate.general_rate.should eql -1.0
      rate.site_users.should_not be_empty
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should be able to revert a dislike' do
      rate = @article.rate
      rate.dislike(@site_user)
      rate.likes.should eql 0
      rate.dislikes.should eql 1
      rate.general_rate.should eql -1.0

      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]


      rate.like(@site_user, true)
      rate.likes.should eql 1
      rate.dislikes.should eql 0
      rate.general_rate.should eql 1.0

      #changing like to dislike should not change number of users ratings
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should not be able to like own article' do
      @article = FactoryGirl.create(:article, site_user: @site_user)
      @article.rate.like(@site_user)
      @article.rate.likes.should eql 0
      @article.rate.dislikes.should eql 0
      @article.rate.general_rate.should eql 0.0

      @article.rate.dislike(@site_user)
      @article.rate.dislikes.should eql 0
      @article.rate.dislikes.should eql 0
      @article.rate.general_rate.should eql 0.0
    end

  end

  context 'blog entry rates' do
    before do
      @site_user = FactoryGirl.create(:site_user, email: "ratings@chess.chess")
      @site_user.reputation = 1.0
      @blog_entry = FactoryGirl.create(:blog_entry)
    end

    it 'should create rate after creating log entry' do
      rate = @blog_entry.rate
      rate.should_not be_nil
      rate.likes.should eql 0
      rate.dislikes.should eql 0
      rate.general_rate.should eql 0.0
      rate.site_users.should be_empty
    end

    it 'should be able to like a blog entry' do
      rate = @blog_entry.rate
      rate.like(@site_user)
      rate.likes.should eql 1
      rate.dislikes.should eql 0
      rate.general_rate.should eql 1.0
      rate.site_users.should_not be_empty
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should be able to revert a like' do
      rate = @blog_entry.rate
      rate.like(@site_user)
      rate.likes.should eql 1
      rate.dislikes.should eql 0
      rate.general_rate.should eql 1.0

      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]

      rate.dislike(@site_user, true)
      rate.likes.should eql 0
      rate.dislikes.should eql 1
      rate.general_rate.should eql -1.0

      #changing like to dislike should not change number of users ratings
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should be able to dislike a blog entry' do
      rate = @blog_entry.rate
      rate.dislike(@site_user)
      rate.likes.should eql 0
      rate.dislikes.should eql 1
      rate.general_rate.should eql -1.0
      rate.site_users.should_not be_empty
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should be able to revert a dislike' do
      rate = @blog_entry.rate
      rate.dislike(@site_user)
      rate.likes.should eql 0
      rate.dislikes.should eql 1
      rate.general_rate.should eql -1.0

      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]


      rate.like(@site_user, true)
      rate.likes.should eql 1
      rate.dislikes.should eql 0
      rate.general_rate.should eql 1.0

      #changing like to dislike should not change number of users ratings
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should not be able to like own blog entry' do
      @blog_entry = FactoryGirl.create(:blog_entry, site_user: @site_user)
      rate = @blog_entry.rate

      rate.like(@site_user)
      rate.likes.should eql 0
      rate.dislikes.should eql 0
      rate.general_rate.should eql 0.0

      rate.dislike(@site_user)
      rate.dislikes.should eql 0
      rate.dislikes.should eql 0
      rate.general_rate.should eql 0.0
    end
  end

  context 'site comments' do
    before do
      @site_user = FactoryGirl.create(:site_user, email: "ratings@chess.chess")
      @site_user.reputation = 1.0
      @site_comment = FactoryGirl.create(:site_comment)
    end

    it 'should create rate after creating site_comment' do
      rate = @site_comment.rate
      rate.should_not be_nil
      rate.likes.should eql 0
      rate.dislikes.should eql 0
      rate.general_rate.should eql 0.0
      rate.site_users.should be_empty
    end

    it 'should be able to like a site comment' do
      rate = @site_comment.rate
      rate.like(@site_user)
      rate.likes.should eql 1
      rate.dislikes.should eql 0
      rate.general_rate.should eql 1.0
      rate.site_users.should_not be_empty
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should be able to revert a like' do
      rate = @site_comment.rate
      rate.like(@site_user)
      rate.likes.should eql 1
      rate.dislikes.should eql 0
      rate.general_rate.should eql 1.0

      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]

      rate.dislike(@site_user, true)
      rate.likes.should eql 0
      rate.dislikes.should eql 1
      rate.general_rate.should eql -1.0

      #changing like to dislike should not change number of users ratings
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should be able to dislike a blog entry' do
      rate = @site_comment.rate
      rate.dislike(@site_user)
      rate.likes.should eql 0
      rate.dislikes.should eql 1
      rate.general_rate.should eql -1.0
      rate.site_users.should_not be_empty
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should be able to revert a dislike' do
      rate = @site_comment.rate
      rate.dislike(@site_user)
      rate.likes.should eql 0
      rate.dislikes.should eql 1
      rate.general_rate.should eql -1.0

      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]


      rate.like(@site_user, true)
      rate.likes.should eql 1
      rate.dislikes.should eql 0
      rate.general_rate.should eql 1.0

      #changing like to dislike should not change number of users ratings
      rate.site_users.to_a.should eql [@site_user]
      @site_user.rates.should_not be_empty
      @site_user.rates.to_a.should eql [rate]
    end

    it 'should not be able to like own blog entry' do
      @site_comment = FactoryGirl.create(:site_comment, site_user: @site_user)
      rate = @site_comment.rate

      rate.like(@site_user)
      rate.likes.should eql 0
      rate.dislikes.should eql 0
      rate.general_rate.should eql 0.0

      rate.dislike(@site_user)
      rate.dislikes.should eql 0
      rate.dislikes.should eql 0
      rate.general_rate.should eql 0.0
    end

    it 'should count rate color' do
      rate = @site_comment.rate
      rate.color.should eql Rate::WHITE
      rate.like(@site_user)
      rate.color.should_not eql Rate::WHITE
      rate.color.should_not eql Rate::GREEN
      rate.color.should eql "#22e022"
    end


  end

end

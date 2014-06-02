require 'active_support/concern'

module UserHelper
  extend ActiveSupport::Concern

  module ClassMethods

    def get_users_comments
      comments = Hash.new(0)
      user_comments = SiteUser.all.map{|user| user.site_comments.count}
      (0..9).each do |n|
        comments["#{n*50}-#{(n+1)*50}"] = user_comments.select{|comments| comments >= n*50 && comments < (n+1)*50 }.count
      end
      comments["500+"] = user_comments.select{|comments| comments >= 500}.count
      comments
    end

    def get_user_ratings
      ratings = Hash.new(0)
      user_ratings = SiteUser.all.map{|user| user.rating }
      ratings["No known rating"] = user_ratings.size - user_ratings.compact.size
      (0..9).each do |n|
        ratings["#{1000+(n*200)}-#{1200+(n*200)}"] = user_ratings.select{|rating| rating >= 1000+(n*200) && rating < 1200+(n*200) }.count
      end
      ratings
    end


    def get_user_birthdays
      birthyear = Hash.new
      user_year = SiteUser.all.map{|u| u.date_of_birth}
      (0..9).each do |n|
        birthyear["#{n*10}-#{(n+1)*10}"] =
        user_year.select{|date| (Date.today-date)/365 > (n*10) && (Date.today-date)/365 < ((n+1)*10) }.count
      end
      birthyear
    end


    def get_user_reputation
      reputation = Hash.new(0)
      user_reputations = SiteUser.all.map{|user| user.reputation }
      (-5..4).each do |n|
        reputation["#{n*20} - #{(n+1)*20}"] =
        user_reputations.select{|rep| rep > (n*20) && rep < ((n+1)*20) }.count
      end
      reputation
    end


    def get_recent_activities
    end

  end

end

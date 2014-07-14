require 'active_support/concern'

module UserHelper
  extend ActiveSupport::Concern

  module ClassMethods

    def get_users_comments
      Statistic.find_by_name('users_comments').try(:destroy)
      comments = Hash.new(0)
      user_comments = SiteUser.all.map{|user| user.site_comments.count}
      (0..9).each do |n|
        comments["#{n*50}-#{(n+1)*50}"] = user_comments.select{|comments| comments >= n*50 && comments < (n+1)*50 }.count
      end
      comments["500+"] = user_comments.select{|comments| comments >= 500}.count
      Statistic.create!(name: 'users_comments', value: comments.inspect)
    end

    def get_user_ratings
      Statistic.find_by_name('users_ratings').try(:destroy)
      ratings = Hash.new(0)
      user_ratings = SiteUser.all.map{|user| user.rating }
      ratings["No known rating"] = user_ratings.size - user_ratings.compact.size
      (0..9).each do |n|
        ratings["#{1000+(n*200)}-#{1200+(n*200)}"] = user_ratings.compact.select{|rating| rating >= 1000+(n*200) && rating < 1200+(n*200) }.count
      end
      Statistic.create!(name: 'users_ratings', value: ratings.inspect)
    end


    def get_user_birthdays
      Statistic.find_by_name('users_birthdays').try(:destroy)
      birthyear = Hash.new
      user_year = SiteUser.all.map{|u| u.date_of_birth}
      birthyear["No date of birth given"] = user_year.size - user_year.compact.size
      (0..9).each do |n|
        birthyear["#{n*10}-#{(n+1)*10}"] =
        user_year.compact.select{|date| (Date.today-date)/365 > (n*10) && (Date.today-date)/365 < ((n+1)*10) }.count
      end
      Statistic.create!(name: 'users_birthdays', value: birthyear.inspect)
    end


    def get_user_reputations
      Statistic.find_by_name('users_reputations').try(:destroy)
      reputation = Hash.new(0)
      user_reputations = SiteUser.all.map{|user| user.reputation }
      (-5..4).each do |n|
        reputation["#{n*20} ~ #{(n+1)*20}"] =
        user_reputations.select{|rep| rep > (n*20) && rep < ((n+1)*20) }.count
      end
      Statistic.create!(name: 'users_reputations', value: reputation.inspect)
    end

    def get_user_countries
      Statistic.find_by_name('users_countries').try(:destroy)
      users_countries_short = SiteUserInformation.group(:country_code).count.select{ |_,v| v > SiteUserInformation.count/200 }
      users_countries = Hash[users_countries_short.map {|k, v| [Country.find_country_by_alpha2(k).try(:name), v] }]
      Statistic.create!(name: 'users_countries', value: users_countries.inspect)
    end


    def get_recent_activities
    end

  end

end

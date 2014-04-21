# -*- coding: utf-8 -*-

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    #primary.item :key_1, t("navigation.tournament.name"), events_path do |tournament|

    #end

    primary.item :key_info, t('news'), blog_entries_path do |site_info|
      site_info.item :key_photoalbum, t('blog.blog'), blog_entries_path
      site_info.item :key_photoalbum, t('article.articles'), articles_path
    end

    primary.item :key_2, 'Players',  players_path do |players|
      players.item :key_2_1, 'Search',  root_path
      players.item :key_2_2, 'Top',  players_path
      players.item :key_2_3, 'Statistics',  players_path
    end

    #   primary.item :key_3, 'Calendar',  root_path do |calendar|
    #     calendar.item :key_3_1, 'Search',  root_path
    #     calendar.item :key_3_2, 'View',  root_path
    #     calendar.item :key_3_3, 'MyCalendar',  root_path
    #   end

    primary.item :key_users, t('site_users'), site_users_path do |user|
      user.item :key_users_search, t('search_users'), site_users_path
      #user.item :key_user_rating, t('user_rating'), rating_site_users_path
    end

  # primary.item :admin, 'Admin', root_path , :if => Proc.new { current_user and current_user.admin? } do |admin|
  # end
  end
end

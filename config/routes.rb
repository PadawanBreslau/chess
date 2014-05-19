# -*- encoding : utf-8 -*-
Chess::Application.routes.draw do
  devise_for :site_users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: 'blog_entries#index'

  resources :players do
    collection do
      get 'statistics'
    end

    member do
      get 'player_stats'
    end
  end

  resources :site_users do
    collection do
      get 'statistics'
    end

    member do
      get 'user_stats'
    end
  end

  resources :blog_entries, :only => ["index","show","update","create","destroy", "new", "edit"]
  resources :site_users, :only => ["index","show","update","create","destroy", "new", "edit"]
  resources :site_user_informations, :only => ["index","show","update","create","destroy", "new", "edit"]
  resources :players, :only => ["index","show","update","create","destroy", "new", "edit"]
  #resources :photos, :only => ["index","show","update","create","destroy", "new", "edit"]
  #resources :photoalbums, :only => ["index","show","update","create","destroy", "new", "edit"]
  resources :player_photos, :only => ["index","show","update","create","destroy", "new", "edit"]
  resources :events, :only => ["index","show","update","create","destroy", "new", "edit"]
  resources :tournaments, :only => ["index","show","update","create","destroy", "new", "edit"]
  resources :rounds, :only => ["show","create", "new", "index", "update", "edit", "destroy"]
  resources :games, :only => ["show","create", "new", "index", "update", "edit", "destroy"]
  resources :articles, :only => ["index","show","update","create","destroy", "new", "edit"]
  resources :site_comments, :only => ["index","show","update","create","destroy", "new", "edit"]
  resources :rates, :only => ["edit"]
  resources :results, :only => ["edit", "destroy"]

  resources :tournaments do
    member do
      get 'results'
      get 'games'
    end
  end
end

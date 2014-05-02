# -*- encoding : utf-8 -*-
Chess::Application.routes.draw do
  get "players/show"
  get "players/index"
  get "players/new"
  get "players/create"
  get "players/edit"
  get "players/update"
  get "players/destroy"
  get "site_user_informations/show"
  get "site_user_informations/edit"
  get "site_user_informations/update"
  get "site_user_informations/destroy"
  devise_for :site_users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'blog_entries#index'

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
    collection do
      get 'results'
      get 'games'
    end
  end

end

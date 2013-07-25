Remix::Application.routes.draw do

  get "wholesale" => "wholesale#index"

  get "subscribe" => "subscriptions#new"
  post "subscribe" => "subscriptions#create", as: :subscriptions

  root to: 'start#index'

  resources :articles, only: [:index, :show]
  resources :albums, only: [:index, :show]
  resources :collections, only: [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


end

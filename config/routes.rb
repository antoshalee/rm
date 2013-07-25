Remix::Application.routes.draw do

  root to: 'start#index'

  resources :articles, only: [:index, :show]
  resources :albums, only: [:index, :show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


end

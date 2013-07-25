Remix::Application.routes.draw do

  get "articles/index"

  get "articles/show"

  root to: 'start#index'

  resources :articles, only: [:index, :show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


end

class OnlyAjaxRequest
  def matches?(request)
    request.xhr?
  end
end

Remix::Application.routes.draw do

  get "feedbacks/create"

  get "wholesale" => "wholesale#index"

  get "subscribe" => "subscriptions#new"
  post "subscribe" => "subscriptions#create", as: :subscriptions
  post "feedback" => "feedbacks#create", as: :feedbacks, constraints: OnlyAjaxRequest.new

  root to: 'start#index'

  resources :articles, only: [:index, :show]
  resources :albums, only: [:index, :show]
  resources :collections, only: [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


end

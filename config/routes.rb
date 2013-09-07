class OnlyAjaxRequest
  def matches?(request)
    request.xhr?
  end
end

Remix::Application.routes.draw do

  get "card/index"

  mount Ckeditor::Engine => '/ckeditor'

  get "wholesale" => "wholesale#index"
  get "catalog" => "catalog_items#index"
  get "subscribe" => "subscriptions#new"
  get "card" => "card#index"
  get "card/check" => "card#check"

  post "subscribe" => "subscriptions#create", as: :subscriptions
  post "feedback" => "feedbacks#create", as: :feedbacks, constraints: OnlyAjaxRequest.new

  root to: 'start#index'

  resources :articles, only: [:index, :show]
  resources :albums, only: [:index, :show]do
    collection do
      get 'tag/:tag', action: :index, as: :tag
    end
  end
  resources :collections, only: [:index] do
    collection do
      get 'tag/:tag', action: :index, as: :tag
    end
  end
  resources :offers, only: [:index, :show] do
    collection do
      get 'tag/:tag', action: :index, as: :tag
    end
  end
  resources :magazines, only: :index

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/:url' => 'pages#show', :constraints => { :url => /.*/ }

end

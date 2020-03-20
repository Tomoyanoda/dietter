Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'

  resources :users, only: [:index, :show, :new, :create, :destroy] do
    member do
      get :followings
      get :followers
      get :likes
    end
    collection do
      get 'searchprofile'
      get 'graph'
    end
  end

  resources :posts, only: [:create, :show, :destroy] do
    collection do
      get 'searchcontent'
      get 'searchweight'
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'

  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end

  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

end

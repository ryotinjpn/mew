Rails.application.routes.draw do
  devise_for :users
  root 'main_pages#home'
  get 'users/new'
  get 'main_pages/home'
  get 'main_pages/help'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:create, :show, :destroy]
  resources :relationships, only: [:create, :destroy]

end
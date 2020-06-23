Rails.application.routes.draw do
  devise_for :users
  root 'main_pages#home'
  get 'users/new'
  get 'main_pages/home'
  get 'main_pages/help'

  resources :users do
    member do
      get :following, :followers, :likes
    end
  end
  
  resources :posts, only: [:create, :show, :destroy] do
    resources :comments, only: [:create,:destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :like_relationships, only: [:create, :destroy]

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
end
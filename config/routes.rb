Rails.application.routes.draw do
  devise_for :users
  root 'main_pages#home'
  get 'main_pages/protection', to: 'main_pages#protection'

  resources :users do
    member do
      get :following, :followers, :likes, :favos
    end
    collection do
      get 'search'
    end
  end
  
  resources :posts, only: [:create, :show, :destroy] do
    resources :comments, only: [:create,:destroy]
    collection do
      get 'search'
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :like_relationships, only: [:create, :destroy]
  resources :favorite_relationships, only: [:create, :destroy]

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
end
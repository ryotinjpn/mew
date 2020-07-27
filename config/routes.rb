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

  resources :posts, only: %i[create show destroy] do
    resources :comments, only: %i[create destroy]
    collection do
      get 'search'
    end
  end

  resources :relationships, only: %i[create destroy]
  resources :like_relationships, only: %i[create destroy]
  resources :favorite_relationships, only: %i[create destroy]

  resources :messages, only: [:create]
  resources :rooms, only: %i[create show index]
end

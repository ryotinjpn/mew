Rails.application.routes.draw do
  devise_for :users
  get 'users/new'
  root 'main_pages#home'
  get 'main_pages/home'
  get 'main_pages/help'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:create, :show, :destroy]

end
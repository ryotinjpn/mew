Rails.application.routes.draw do
  get 'users/new'
  root 'main_pages#home'
  get 'main_pages/home'
  get 'main_pages/help'

end

Rails.application.routes.draw do
  root 'main_pages#home'
  get 'main_pages/home'
  get 'main_pages/help'

end

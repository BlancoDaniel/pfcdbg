Rails.application.routes.draw do
  root 'main#home'
  resources :categories, except: :show
  devise_for :users
end

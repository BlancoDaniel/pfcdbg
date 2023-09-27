Rails.application.routes.draw do
  root 'main#home'
  resources :categories, except: :show
  resources :clients, only: [:new, :create]
  resources :promoters, only: [:new, :create]
  devise_for :users
end

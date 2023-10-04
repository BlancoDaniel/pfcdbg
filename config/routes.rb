Rails.application.routes.draw do
  root 'main#home'
  devise_for :users, controllers: { registrations: "registrations" }
  resources :categories, except: :show
  resources :clients, only: [:new, :create]
  resources :promoters, only: [:new, :create]
  resources :events
end

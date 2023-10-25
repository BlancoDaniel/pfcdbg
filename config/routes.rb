Rails.application.routes.draw do
  root 'main#home'
  devise_for :users, controllers: { registrations: "registrations" }
  resources :categories, except: :show
  resources :clients, only: [:new, :create]
  resources :promoters, only: [:show, :new, :create], path: '/promoter', param: :id
  resources :events
  resources :orders
  get "checkout", to: "checkouts#show"
  get "checkout/success", to: "checkouts#success"


end

Rails.application.routes.draw do
  root 'main#index'
  devise_for :users, controllers: { registrations: "registrations" }
  resources :categories, except: :show
  resources :clients, only: [:new, :create]
  resources :promoters, only: [:show, :new, :create], path: '/promoter', param: :id
  resources :events
  resources :orders, only: [:show, :new]
  get "checkout", to: "checkouts#show"
  post 'checkouts/:id/destroy_checkout_session', to: 'checkouts#destroy_checkout_session', as: 'destroy_checkout_session'




end

Rails.application.routes.draw do
  root 'articles#index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :articles#, only: [:index ,:new , :create]
  resources :subscriptions, only: [:create, :destroy]
end

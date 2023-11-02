Rails.application.routes.draw do
  root 'articles#index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'my_articles', to: 'articles#my_articles'
  get 'subscripted_article', to: 'articles#subscripted_article'
  resources :articles
  resources :subscriptions, only: [:create, :destroy]
  resources :users, only: [:new, :create]
end

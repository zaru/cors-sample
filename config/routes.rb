Rails.application.routes.draw do
  resources :articles
  namespace :embed do
    resources :articles, only: [:new, :create]
    resources :vulnerable_articles, only: [:new, :create]
    resource :thanks, only: [:show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

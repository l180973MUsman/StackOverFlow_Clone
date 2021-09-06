Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users

  get 'posts/questions'
  get 'users/show'
  get 'search', to: "posts#search"

  resources :main, only: [:index]
  resources :users 
  resources :posts do
    member do
      put "like", to: "posts#upvote"
      put "unlike", to: "posts#downvote"
    end
    resources :comments do
      member do
        put "like", to: "comments#upvote"
        put "unlike", to: "comments#downvote"
      end
    end
  end
  
  root "main#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

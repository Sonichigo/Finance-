Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'welcome#index'
  get 'my-portfolio', to: 'users#my_portfolio'
  get 'my-friends', to: 'users#my_friends'
  get 'search-stock', to: 'stocks#search'
  get 'search-friend', to: 'users#search'
  resources :users, only: [:show]
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :welcome
end

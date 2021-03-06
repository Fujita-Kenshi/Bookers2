Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update] #:create, 
  post "users/:id" => "users#show"
  
  # get 'users/show'
  # get 'users/edit'
  
  get "home/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

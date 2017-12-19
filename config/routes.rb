Rails.application.routes.draw do
  resources :expenses


  resources :users

  match 'expenses'=> 'expenses#index', :via => :get

  root 'users#index'
end

Rails.application.routes.draw do
  resources :expenses


  resources :users

  match 'expenses'=> 'expenses#index', :via => :get
  match 'expense' => 'application#parse', :via => :post

end

Rails.application.routes.draw do

  match 'expenses'=> 'expenses#index', :via => :get
  match 'expense' => 'api#parse', :via => :post
  root :to => 'application#hello'
end

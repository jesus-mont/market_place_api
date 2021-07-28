Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :products, :only => [:create, :update, :destroy]
  end  
  resources :sessions, :only => [:create, :destroy]
  resources :products, :only => [:show, :index]
  
end

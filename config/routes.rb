Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get 'home/index'

  resources :medicines
  resources :doctors do
    get 'login', :on => :collection
    post 'signin', :on => :collection
    get 'logout', :on => :collection
  end

  resources :patients do
    get 'login', :on => :collection
    post 'signin', :on => :collection
    get 'logout', :on => :collection
  end













  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  get 'reports/index'
  get 'reports/report'
  get 'main/index'
  resources :operations
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'operations#index'
end

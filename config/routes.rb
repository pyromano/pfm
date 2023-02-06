Rails.application.routes.draw do
  get 'reports/index'
  get 'reports/report_by_category'
  get 'reports/report_by_dates'
  get 'reports/report_by_dates/category/:category_id', to: 'reports#report_by_dates_per_category',
                                                       as: 'reports_report_by_dates_per_category'
  get 'main/index'
  resources :operations
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'operations#index'
end

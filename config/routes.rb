Rails.application.routes.draw do
  get 'dashboard', to: 'dashboard#index'
  devise_for :users
  resources :hospitals
  resources :doctors
  resources :patients
  resources :appointments
  resources :medical_records
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "main#index"
end

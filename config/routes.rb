Rails.application.routes.draw do
  get 'users/show'
  get 'dashboard', to: 'dashboard#index'
  devise_for :users
  resources :hospitals
  resources :doctors
  resources :patients
  resources :appointments
  resources :medical_records
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show]
  get 'users/:id/medical_records', to: 'users#medical_records', as: 'user_medical_records'
  get 'users/:id/doctor_info', to: 'users#doctor_info', as: 'user_doctor_info'
  # Defines the root path route ("/")
  root "main#index"
end

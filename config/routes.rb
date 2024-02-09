Rails.application.routes.draw do
  root 'pages#dashboard'
  resources :users, only: [:show, :update]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get "up" => "rails/health#show", as: :rails_health_check
end

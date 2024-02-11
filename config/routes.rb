Rails.application.routes.draw do
  root 'pages#dashboard'
  resources :users, only: [:show, :update]

  patch '/add_friend', to: 'users#add_friend'
  patch '/accept/:id', to: 'users#accept_friend', as: :accept
  patch '/reject/:id', to: 'users#reject_friend', as: :reject

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get "up" => "rails/health#show", as: :rails_health_check
end

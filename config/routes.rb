Rails.application.routes.draw do
  resources :reservations
  resources :flights

  devise_for :users

  post '/reservations/create/:id', to: 'reservations#create'

  get 'ajax_show_reservation/index'
  get '/ajax_show_reservation/:id', to: 'ajax_show_reservation#show'
  get '/reservations/delete/:id', to: 'reservations#destroy'
  get 'compte/index'
  get 'home/index'

  root to: "home#index"
end

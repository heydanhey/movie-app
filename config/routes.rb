Rails.application.routes.draw do
  resources :theaters
  root :to => 'movies#index'
  resources :movies
  resources :orders#, only: [:create, :index]
  get 'ticket_window/:id' => 'orders#ticket_window', as: 'ticket_window'
end

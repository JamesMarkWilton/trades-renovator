Rails.application.routes.draw do
  root 'login#index'
  get 'auth/procore/callback', to: 'login#callback'

  resources :trades, only: [:new, :create, :index]
end

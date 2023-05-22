Rails.application.routes.draw do
  root 'login#index'
  get 'auth/procore/callback', to: 'login#callback'

  resources :trades, only: [:new, :create]
  resources :bidders, only: [:new, :create]
end

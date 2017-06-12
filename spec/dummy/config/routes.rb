Rails.application.routes.draw do
  resources :welcome, only: [:index]
  root 'welcome#index'

  resources :users, only: [:new, :create]
end


Rails.application.routes.draw do
  resources :event_members
  resources :members
  resources :events, only: [:show, :new, :edit, :update, :create]
  namespace :connect do
    resource :facebook, only: :create
  end
  resource :dashboard, only: :show
  resource :session, only: :destroy

  root to: 'top#index'
end

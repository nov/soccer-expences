Rails.application.routes.draw do
  resources :accounts, only: [:index] do
    scope module: :account do
      resource :viewer, only: :create
      resource :admin, only: :create
    end
  end
  resources :members, except: :destroy
  resources :events, only: [:show, :new, :edit, :update, :create] do
    scope module: :event do
      resources :members, only: [:index, :update]
      resource :expense, only: [:update]
    end
  end
  namespace :connect do
    resource :facebook, only: :create
    resource :google, only: :create
  end
  resource :dashboard, only: [:show, :update]
  resource :session, only: :destroy

  root to: 'top#index'
end

Rails.application.routes.draw do
  resources :accounts, only: [:index] do
    member do
      post :approve
    end
  end
  resources :members, except: :destroy
  resources :events, only: [:show, :new, :edit, :update, :create] do
    resources :members, controller: :event_members, only: [:index, :update]
  end
  namespace :connect do
    resource :facebook, only: :create
  end
  resource :dashboard, only: [:show, :update]
  resource :session, only: :destroy

  root to: 'top#index'
end

Rails.application.routes.draw do
  namespace :connect do
    resource :facebook, only: :create
  end
  resource :dashboard, only: :show
  resource :session, only: :destroy

  root to: 'top#index'
end

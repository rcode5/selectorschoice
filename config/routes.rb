# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tracks, only: %i[index show]

  resources :tags, only: [:index], constraints: { format: /json/ }

  resources :about, only: [:index]

  resources :admin, only: :index
  namespace :admin do
    resources :files
    resources :tracks do
      member do
        get :clone
      end
    end
  end

  # reroute clearance endpoints to use our derived controllers for auth
  resources :passwords, controller: 'passwords',
                        only: %i[create new]

  resource :session, controller: 'sessions',
                     only: %i[create new destroy]

  resources :users, controller: 'users', only: %i[create new] do
    resource :password, controller: 'passwords',
                        only: %i[create edit update]
  end

  resource :search, only: :show, controller: 'search'
  resource :feed, only: :show, controller: 'feed', defaults: { format: :xml }

  # clearance routes define sign_in and sign_out

  root to: 'welcome#index'
end

SelectorsChoice::Application.routes.draw do
  resources :tracks, only: [:index, :show]

  resources :tags, only: [:index], constraints: {format: /json/}

  resources :about, only: [:index]

  resources :admin, only: :index
  namespace :admin do
    resources :tracks do
      member do
        get :clone
      end
    end
    resource :palette, only: [:show]
  end

  # reroute clearance endpoints to use our derived controllers for auth
  resources :passwords, controller: 'passwords',
    only: [:create, :new]

  resource :session, controller: 'sessions',
    only: [:create, :new, :destroy]

  resources :users, controller: 'users', only: [:create, :new] do
    resource :password, controller: 'passwords',
      only: [:create, :edit, :update]
  end

  # clearance routes define sign_in and sign_out

  root to: 'welcome#index'
end

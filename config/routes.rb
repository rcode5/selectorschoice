SelectorsChoice::Application.routes.draw do
  resources :tracks, only: [:index, :show]

  resources :admin, only: :index
  namespace :admin do
    resources :tracks
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

  match '/sign_in' => 'sessions#new', :as => 'sign_in'
  match '/sign_out' => 'sessions#destroy', :as => 'sign_out', :via => :delete
  match '/sign_in' => redirect('/')

  root :to => 'welcome#index'

end

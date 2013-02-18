SelectorsChoice::Application.routes.draw do
  resources :tracks, only: [:index, :show]

  resources :admin, only: :index
  namespace :admin do
    resources :tracks
  end

  root :to => 'welcome#index'

end

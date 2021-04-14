Rails.application.routes.draw do
  resources :artists, except: [:show]
  
  resources :artists, only: [:show] do
    resources :songs, only: [:show, :index]
  end
  
  # still want users to be able to see all songs, create and edit songs, etc.
  resources :songs, only: [:index, :show, :new, :create, :edit, :update]
end

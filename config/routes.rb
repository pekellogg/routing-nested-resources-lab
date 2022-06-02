Rails.application.routes.draw do

  resources :artists, only: [:index, :new, :edit]
  resources :songs, only: [:index, :show, :new, :create, :edit, :update]

  resources :artists, only: [:show] do
    resources :songs, only: [:show, :index]
  end

  # root 'songs#index'
end

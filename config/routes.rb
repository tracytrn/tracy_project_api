Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  namespace :api do
    namespace :v1 do
      resources :users
      post '/login', to: 'sessions#create'
    end
  end
end

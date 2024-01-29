Rails.application.routes.draw do
  get 'users/profile'
    resources :categories do
      resources :posts do
        member do
          post 'likes'
          delete 'unlike'
        end
        resources :comments, only: [:create, :destroy]
      end
    end
  get '/u/:id', to: 'users#profile', as: 'user'
  get 'about', to: 'pages#about'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end

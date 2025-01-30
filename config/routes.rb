Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '/profile', to: 'users#profile', as: :profile

  resources :users, only: [] do
    member do
      get 'profile'
    end
  end

  resources :roasteries, only: [:index, :show, :new, :create, :edit, :update] do
    collection do
      get 'search'
    end

    resources :roastery_comments, only: [:create]
    resources :roastery_reviews, only: [:create]
  end

  resources :beans, only: [:index, :new, :create, :show, :edit, :update] do
    resources :recipes, only: [:new, :create, :edit, :update, :destroy]
    resources :bean_reviews, only: [:create]
    resources :bean_comments, only: [:create, :destroy]
  end

  get 'beans', to: 'beans#index'
end

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

  resources :roasteries, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'search'
    end

    resources :roastery_comments, only: [:create, :destroy] do
      resource :roastery_comment_votes, only: [:create, :destroy]
    end
    resources :roastery_reviews, only: [:create]

    resource :favourite_roastery, only: [:create, :destroy], controller: 'favourite_roasteries'
    resources :roastery_photos, only: [:create]
  end

  resources :beans, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :recipes, only: [:new, :create, :edit, :update, :destroy]
    resources :bean_reviews, only: [:create]
    resources :bean_comments, only: [:create, :destroy] do
      resource :bean_comment_votes, only: [:create, :destroy]
    end
    resource :favourite_bean, only: [:create, :destroy], controller: 'favourite_beans'
    resources :bean_photos, only: [:create]
  end

  get 'beans', to: 'beans#index'
end

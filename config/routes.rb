Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "quizzes#index"

  resources :quizzes, only: [:index, :show] do
    member do
      get :start
      post :finish
    end

    resources :questions, only: [:show] do
      resources :guesses, only: [:create]
    end
  end

  resources :user_quizzes, only: [] do
    member do
      patch :replay
    end
  end
end

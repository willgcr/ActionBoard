Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout",
    registration: "register"
  }, controllers: {
    passwords: "users/passwords",
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
    get "lists", to: "dashboard#lists", as: :user_lists
    get "tasks", to: "dashboard#tasks", as: :user_tasks
    resources :tasks, only: [:new, :create, :show, :update, :edit, :destroy]
    resources :lists, only: [:new, :create, :show, :update, :edit, :destroy]
    resources :lists do
      member do
        get :share
        post :share_submit
      end
    end
  end

  unauthenticated do
    root(to: 'home#index')
    get :setup, to: 'setup#index'
  end

end

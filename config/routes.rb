Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :trips do
    resources :tasks, only: %i[create update]
  end
  resources :tasks, only: :delete
  get "users/:id/profile", to: "pages#profile", as: :user_profile
end

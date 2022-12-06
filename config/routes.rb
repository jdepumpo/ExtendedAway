Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  namespace :users do
    root to: "trips#index"
  end

  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :trips do
    resources :tasks, only: %i[create]
  end

  resources :tasks, only: %i[destroy update]

  get "users/:id/profile", to: "pages#profile", as: :user_profile
  # patch "trips/:trip_id/tasks/:id", to: "tasks#complete", as: :task_complete
  # patch "trips/:trip_id/tasks/:id", to: "tasks#uncomplete", as: :task_uncomplete
  post "trips/:trip_id/set_caretaker/:user_id", to: "tasks#set_caretaker", as: "set_caretaker"
end

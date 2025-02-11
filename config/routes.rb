Rails.application.routes.draw do
  root "books#index"
  resources :books, only: [:index, :show] do
    member do
      post :borrow
    end
  end

  resources :borrowings, only: [] do
    member do
      delete :return_book
    end
  end

  resources :users, only: [:show]

  get "/signup", to: "auth#new_signup"
  get "/login", to: "auth#new_login"
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"

  get "/profile", to: "users#show", as: :profile

  # root "books#index"
end

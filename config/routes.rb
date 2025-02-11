Rails.application.routes.draw do
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

  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"

  root "books#index"
end

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#home"

  resources :posts do
    resources :comments
  end

  resources :comments, only: [:edit, :update, :destroy] do
    resources :comments
  end

  resources :events do
    resources :comments
  end
end

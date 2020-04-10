Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  namespace :admin do
    resources :questions, only: [:index, :create, :update, :destroy]
  end
  resources :wordbooks, only: [:index]
  resources :users, only: [:new, :create] do
    collection do
      post :api
    end
  end
  resources :questions, only: [:index]
  resources :ranking, only: [:index]
end

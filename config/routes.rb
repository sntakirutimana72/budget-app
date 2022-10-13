Rails.application.routes.draw do
  root 'categories#index'
  get 'get-started', to: 'splash#index'

  devise_for :users

  resources :categories, only: %i[create new] do
    resources :entities, only: %i[new create index]
  end
end

Rails.application.routes.draw do
  root 'splash#index'

  devise_for :users

  resources :categories, only: %i[index create new] do
    resources :entities, only: %i[index new create]
  end
end

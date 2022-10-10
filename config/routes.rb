Rails.application.routes.draw do
  root 'home#splash'

  devise_for :users
end

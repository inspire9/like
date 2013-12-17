Rails.application.routes.draw do
  namespace :like do
    resources :likes, only: [:create, :destroy]
  end
end

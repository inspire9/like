Rails.application.routes.draw do
  devise_for :users

  resources :articles

  mount Like::Engine => '/'

  root to: 'articles#index'
end

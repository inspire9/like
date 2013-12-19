Rails.application.routes.draw do
  devise_for :users

  resources :articles

  mount Like::Engine => '/'
  mount Like::API    => '/api/likes'

  root to: 'articles#index'
end

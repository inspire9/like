Like::Engine.routes.draw do
  namespace :like do
    post   'likes', to: 'likes#create', as: :likes
    delete 'likes', to: 'likes#destroy'
  end
end

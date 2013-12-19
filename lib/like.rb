require 'rails'

module Like
  mattr_accessor :interaction_class
end

require 'like/engine'
require 'like/interaction'
require 'like/api' if defined?(Grape)

Like.interaction_class = Like::Interaction

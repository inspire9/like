require 'rails'

module Like
  mattr_accessor :interaction_class
end

require 'like/engine'
require 'like/interaction'

Like.interaction_class = Like::Interaction

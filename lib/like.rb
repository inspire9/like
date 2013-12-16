module Like
  def self.link(liker, likeable)
    Like::Like.create liker: liker, likeable: likeable
  end
end

require 'like/engine'

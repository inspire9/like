class Like::Like < ActiveRecord::Base
  self.table_name = 'like_likes'

  belongs_to :liker,    polymorphic: true
  belongs_to :likeable, polymorphic: true

  validates :liker,    presence: true
  validates :likeable, presence: true

  def self.like(liker, likeable)
    create liker: liker, likeable: likeable
  end
end

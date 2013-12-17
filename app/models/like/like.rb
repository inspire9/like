class Like::Like < ActiveRecord::Base
  self.table_name = 'like_likes'

  belongs_to :liker,    polymorphic: true
  belongs_to :likeable, polymorphic: true

  validates :liker,    presence: true
  validates :likeable, presence: true

  def self.like(liker, likeable)
    create liker: liker, likeable: likeable
  end

  def self.liking?(liker, likeable)
    return false if liker.nil? || likeable.nil?

    where(
      liker_type:    liker.class.name,    liker_id:    liker.id,
      likeable_type: likeable.class.name, likeable_id: likeable.id
    ).count > 0
  end

  def self.unlike(liker, likeable)
    where(
      liker_type:    liker.class.name,    liker_id:    liker.id,
      likeable_type: likeable.class.name, likeable_id: likeable.id
    ).each &:destroy
  end
end

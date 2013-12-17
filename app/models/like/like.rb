class Like::Like < ActiveRecord::Base
  self.table_name = 'like_likes'

  belongs_to :liker,    polymorphic: true
  belongs_to :likeable, polymorphic: true

  validates :liker,    presence: true
  validates :likeable, presence: true

  scope :with_liker,    lambda { |liker|
    where liker_type: liker.class.name, liker_id: liker.id
  }
  scope :with_likeable, lambda { |likeable|
    where likeable_type: likeable.class.name, likeable_id: likeable.id
  }

  def self.like(liker, likeable)
    create liker: liker, likeable: likeable
  end

  def self.liking?(liker, likeable)
    return false if liker.nil? || likeable.nil?

    with_liker(liker).with_likeable(likeable).count > 0
  end

  def self.unlike(liker, likeable)
    with_liker(liker).with_likeable(likeable).each &:destroy
  end
end

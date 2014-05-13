class AddTimestampsToLikes < ActiveRecord::Migration
  def change
    add_column :like_likes, :created_at, :datetime
    add_column :like_likes, :updated_at, :datetime
  end
end

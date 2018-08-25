superclass = ActiveRecord::VERSION::MAJOR < 5 ?
  ActiveRecord::Migration : ActiveRecord::Migration[4.2]
class AddTimestampsToLikes < superclass
  def change
    add_column :like_likes, :created_at, :datetime
    add_column :like_likes, :updated_at, :datetime
  end
end

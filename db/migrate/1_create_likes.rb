class CreateLikes < ActiveRecord::Migration
  def change
    create_table :like_likes do |t|
      t.string  :liker_type,    null: false
      t.integer :liker_id,      null: false
      t.string  :likeable_type, null: false
      t.integer :likeable_id,   null: false
    end

    add_index :like_likes, [:liker_type, :liker_id, :likeable_type,
      :likeable_id], name: :unique_like_likes, unique: true
  end
end

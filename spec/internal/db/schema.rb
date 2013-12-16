ActiveRecord::Schema.define do
  create_table :articles, :force => true do |t|
    t.timestamps
  end

  create_table :users, :force => true do |t|
    t.timestamps
  end
end

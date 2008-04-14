class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.column :forum_id, :integer
      t.column :user_id, :integer
      t.column :name, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :posts_count, :integer, :null => false, :default => 0
    end
    add_index :topics, :forum_id
  end

  def self.down
    drop_table :topics
  end
end

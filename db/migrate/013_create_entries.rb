class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :body, :text      
      t.column :comments_count, :integer, :null => false, :default => 0
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
    add_index :entries, :user_id
  end

  def self.down
    drop_table :entries
  end
end

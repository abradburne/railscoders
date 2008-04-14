class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :entry_id, :integer
      t.column :user_id, :integer
      t.column :guest_name, :string
      t.column :guest_email, :string
      t.column :guest_url, :string
      t.column :body, :text
      t.column :created_at, :datetime
    end
    add_index :comments, :entry_id
  end

  def self.down
    drop_table :comments
  end
end

class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :topics_count, :integer, :null => false, :default => 0
    end
  end

  def self.down
    drop_table :forums
  end
end

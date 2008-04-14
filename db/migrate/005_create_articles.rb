class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :synopsis, :text, :limit => 1000
      t.column :body, :text, :limit => 20000
      t.column :published, :boolean, :default => false
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :published_at, :datetime
      t.column :category_id, :integer
    end
  end

  def self.down
    drop_table :articles
  end
end

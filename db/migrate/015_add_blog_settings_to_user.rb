class AddBlogSettingsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :entries_count, :integer, :null => false, :default => 0
    add_column :users, :blog_title, :string
    add_column :users, :enable_comments, :boolean, :default => true
  end

  def self.down
    remove_column :users, :entries_count
    remove_column :users, :blog_title
    remove_column :users, :enable_comments
  end
end

class AddFlickrUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :flickr_username, :string
    add_column :users, :flickr_id, :string
  end

  def self.down
    remove_column :users, :flickr_username
    remove_column :users, :flickr_id
  end
end

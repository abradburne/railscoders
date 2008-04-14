class AddUsersLatestActivity < ActiveRecord::Migration
  def self.up
    add_column :users, :last_activity, :string
    add_column :users, :last_activity_at, :datetime
  end

  def self.down
    remove_column :users, :last_activity
    remove_column :users, :last_activity_at
  end
end
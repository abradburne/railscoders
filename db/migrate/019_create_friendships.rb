class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.column :user_id, :integer, :null => false
      t.column :friend_id, :integer, :null => false
      t.column :xfn_friend, :boolean, :default => false, :null => false
      t.column :xfn_acquaintance, :boolean, :default => false, :null => false
      t.column :xfn_contact, :boolean, :default => false, :null => false
      t.column :xfn_met, :boolean, :default => false, :null => false
      t.column :xfn_coworker, :boolean, :default => false, :null => false
      t.column :xfn_colleague, :boolean, :default => false, :null => false
      t.column :xfn_coresident, :boolean, :default => false, :null => false
      t.column :xfn_neighbor, :boolean, :default => false, :null => false
      t.column :xfn_child, :boolean, :default => false, :null => false
      t.column :xfn_parent, :boolean, :default => false, :null => false
      t.column :xfn_sibling, :boolean, :default => false, :null => false
      t.column :xfn_spouse, :boolean, :default => false, :null => false
      t.column :xfn_kin, :boolean, :default => false, :null => false
      t.column :xfn_muse, :boolean, :default => false, :null => false
      t.column :xfn_crush, :boolean, :default => false, :null => false
      t.column :xfn_date, :boolean, :default => false, :null => false
      t.column :xfn_sweetheart, :boolean, :default => false, :null => false
    end
    
    add_index :friendships, [:user_id, :friend_id]
  end

  def self.down
    drop_table :friendships
  end
end
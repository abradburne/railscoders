class CreateUsertemplates < ActiveRecord::Migration
  def self.up
    create_table :usertemplates do |t|
      t.column :user_id, :integer
      t.column :name, :string
      t.column :body, :text
    end
    add_index :usertemplates, [:user_id, :name]  end

  def self.down
    drop_table :usertemplates
  end
end

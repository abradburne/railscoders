class CreateNewsletters < ActiveRecord::Migration
  def self.up
    create_table :newsletters do |t|
      t.column :subject, :string
      t.column :body, :text
      t.column :sent, :boolean, :null => false, :default => false
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :newsletters
  end
end

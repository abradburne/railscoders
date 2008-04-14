class AddGeoToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :geo_lat, :float
    add_column :photos, :geo_long, :float
    add_column :photos, :show_geo, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :photos, :geo_lat
    remove_column :photos, :geo_long
    remove_column :photos, :show_geo
  end
end

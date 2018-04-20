class AddLatitudeAndLongitudeToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :latitude, :float
    add_column :addresses, :longitude, :float
  end
end

class RemoveLatitudeAndLongitudeFromAddresses < ActiveRecord::Migration[5.1]
  def change
    remove_column :addresses, :latitude, :float
    remove_column :addresses, :longitude, :float
  end
end

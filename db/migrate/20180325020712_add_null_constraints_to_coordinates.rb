class AddNullConstraintsToCoordinates < ActiveRecord::Migration[5.1]
  def change
    change_column_null :coordinates, :latitude, false
    change_column_null :coordinates, :longitude, false
  end
end

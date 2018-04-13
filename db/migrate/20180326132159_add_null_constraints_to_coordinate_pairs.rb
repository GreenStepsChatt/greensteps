class AddNullConstraintsToCoordinatePairs < ActiveRecord::Migration[5.1]
  def change
    change_column_null :coordinate_pairs, :latitude, false
    change_column_null :coordinate_pairs, :longitude, false
  end
end

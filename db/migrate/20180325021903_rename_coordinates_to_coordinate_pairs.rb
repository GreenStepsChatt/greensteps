class RenameCoordinatesToCoordinatePairs < ActiveRecord::Migration[5.1]
  def up
    drop_table :coordinates
    create_table :coordinate_pairs do |t|
      t.float :latitude
      t.float :longitude
      t.references :locateable, polymorphic: true

      t.timestamps
    end
  end

  def down
    create_table :coordinates do |t|
      t.float :latitude
      t.float :longitude
      t.references :locateable, polymorphic: true

      t.timestamps
    end
  end
end

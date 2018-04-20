class CreateCoordinates < ActiveRecord::Migration[5.1]
  def change
    create_table :coordinates do |t|
      t.float :latitude
      t.float :longitude
      t.references :locateable, polymorphic: true

      t.timestamps
    end
  end
end

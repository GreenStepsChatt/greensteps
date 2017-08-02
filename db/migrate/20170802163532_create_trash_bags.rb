class CreateTrashBags < ActiveRecord::Migration[5.0]
  def change
    create_table :trash_bags do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

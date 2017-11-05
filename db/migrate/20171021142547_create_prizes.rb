class CreatePrizes < ActiveRecord::Migration[5.0]
  def change
    create_table :prizes do |t|
      t.string :title
      t.integer :quantity
      t.integer :cost

      t.timestamps
    end
  end
end

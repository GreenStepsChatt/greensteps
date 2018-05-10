class AddRedemptions < ActiveRecord::Migration[5.1]
  def change
    create_table :redemptions do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.integer :cost

      t.timestamps
    end
  end
end

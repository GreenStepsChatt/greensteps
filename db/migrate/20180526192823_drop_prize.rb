class DropPrize < ActiveRecord::Migration[5.2]
  def up
    remove_column :redemptions, :prize_id
    drop_table :prizes
  end
end

class RemoveMilesFromDeed < ActiveRecord::Migration[5.1]
  def change
    remove_column :deeds, :miles, :integer
  end
end

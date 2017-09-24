class AddTrashBagsMilesToDeed < ActiveRecord::Migration[5.0]
  def change
    add_column :deeds, :trash_bags, :integer
    add_column :deeds, :miles, :integer
  end
end

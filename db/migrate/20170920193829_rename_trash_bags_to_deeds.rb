class RenameTrashBagsToDeeds < ActiveRecord::Migration[5.0]
  def change
    rename_table :trash_bags, :deeds
  end
end

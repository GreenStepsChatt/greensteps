class AddDeedConstraints < ActiveRecord::Migration[5.0]
  def up
    change_column :deeds, :miles, :integer, default: 1, null: false
    change_column :deeds, :trash_bags, :integer, default: 1, null: false
  end

  def down
    change_column :deeds, :miles, :integer, default: nil, null: true
    change_column :deeds, :trash_bags, :integer, default: nil, null: true
  end
end

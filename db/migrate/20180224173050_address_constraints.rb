class AddressConstraints < ActiveRecord::Migration[5.1]
  def up
    change_column_null :addresses, :street, false
    change_column_null :addresses, :city, false
    change_column :addresses, :state, :string, null: false, limit: 2
    change_column :addresses, :zip, :string, null: false
  end

  def down
    change_column_null :addresses, :street, true
    change_column_null :addresses, :city, true
    change_column :addresses, :state, :string, null: true, limit: nil
    change_column :addresses, :zip, :integer, null: true
  end
end

class AddNullConstraintsBackToAddresses < ActiveRecord::Migration[5.1]
  def change
    change_column_null :addresses, :street, false
    change_column_null :addresses, :city, false
    change_column_null :addresses, :state, false
    change_column_null :addresses, :zip, false
  end
end

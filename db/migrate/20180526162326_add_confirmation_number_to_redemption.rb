class AddConfirmationNumberToRedemption < ActiveRecord::Migration[5.2]
  def change
    add_column :redemptions, :confirmation_number, :string
  end
end

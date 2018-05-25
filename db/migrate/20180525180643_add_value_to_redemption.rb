class AddValueToRedemption < ActiveRecord::Migration[5.2]
  def change
    add_column :redemptions, :value, :integer
  end
end

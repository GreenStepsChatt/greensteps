class AddAddressableToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :addressable, polymorphic: true
  end
end

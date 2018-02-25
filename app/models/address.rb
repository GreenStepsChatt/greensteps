class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  validates :street, :city, :state, :zip, presence: true
  validates :state, length: { is: 2 }
  validates :zip, length: { minimum: 5 }
end

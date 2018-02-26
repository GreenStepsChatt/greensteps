class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  validates :street, :city, :state, :zip, presence: true
  validates :state,
            length: { is: 2 },
            format: {
              with: /\A[A-Z]+\z/,
              message: 'only allows uppercase letters'
            }
  validates :zip, format: {
    with: /\A\d{5}(-\d{4})?\z/,
    message: 'must be of the format xxxxx or xxxxx-xxxx'
  }
end

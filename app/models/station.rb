class Station < ApplicationRecord
  validates :name, presence: true
  has_one :address,
          as: :addressable,
          dependent: :destroy,
          inverse_of: :addressable # TODO: not needed in rails 5.2
  has_one :coordinate_pair,
          as: :locateable,
          dependent: :destroy,
          inverse_of: :locateable # TODO: not needed in rails 5.2
end

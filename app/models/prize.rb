class Prize < ApplicationRecord
  validates :cost, :quantity, numericality: { greater_than: 0 }
  validates :title, :cost, :quantity, presence: true

  scope :by_cost, -> { order :cost }
end

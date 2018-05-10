class Deed < ApplicationRecord
  belongs_to :user
  validates :trash_bags, numericality: { greater_than: 0 }
end

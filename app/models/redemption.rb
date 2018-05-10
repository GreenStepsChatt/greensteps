class Redemption < ApplicationRecord
  belongs_to :user
  validates_with RedemptionValidator
end

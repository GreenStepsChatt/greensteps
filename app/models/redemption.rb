class Redemption < ApplicationRecord
  belongs_to :user
  validates :value, presence: true
  scope :this_month, -> { where(created_at: Time.zone.today.all_month) }
  scope :total_cost, -> { sum(:value) }
end

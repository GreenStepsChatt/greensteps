class Deed < ApplicationRecord
  belongs_to :user
  validate :something_was_done,
           if: ->(deed) { deed.trash_bags.present? }
  validates :trash_bags, presence: true

  def something_was_done
    errors.add(:base, :nothing_was_done) if trash_bags < 1
  end
end

class Deed < ApplicationRecord
  belongs_to :user
  validate :something_was_done,
           if: ->(deed) { deed.miles.present? && deed.trash_bags.present? }
  validates :miles, :trash_bags, presence: true

  def something_was_done
    errors.add(:base, :nothing_was_done) if (trash_bags + miles) < 1
  end
end

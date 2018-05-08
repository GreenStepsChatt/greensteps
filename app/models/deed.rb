class Deed < ApplicationRecord
  belongs_to :user
  has_one_attached :before_photo
  has_one_attached :after_photo

  validates :trash_bags, numericality: { greater_than: 0 }

  # Bullet is reporting an N+1 query on the save method... probably because we
  # have two attached files (typically you'd use has_many_attached for more than
  # one attachment). Don't want to add this case to the Bullet whitelist because
  # if other places do cause an N+1 query on one of the attachment associations
  # then we want to know about it.
  if defined?(Bullet)
    before_save { Bullet.n_plus_one_query_enable = false }
    after_save { Bullet.n_plus_one_query_enable = true }
  end
end

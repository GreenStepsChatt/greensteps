class Address < ApplicationRecord
  VALUE_ATTRIBUTES = %w[street city state zip].freeze

  belongs_to :addressable, polymorphic: true
  has_one :coordinate_pair,
          as: :locateable,
          dependent: :destroy,
          inverse_of: :locateable # TODO: not needed in rails 5.2

  validates :street, :city, :state, :zip, presence: true

  validates :state,
            length: { is: 2 },
            format: {
              with: /\A[A-Z]+\z/,
              message: 'only allows uppercase letters'
            }
  validates :zip,
            format: {
              with: /\A\d{5}(-\d{4})?\z/,
              message: 'must be of the format xxxxx or xxxxx-xxxx'
            }

  scope :for_station, -> { where(addressable_type: 'Station') }

  def self.not_geocoded
    left_joins(:coordinate_pair).where(coordinate_pairs: { id: nil })
  end

  def to_sentence
    "#{street}, #{city}, #{state} #{zip}"
  end

  def saved_value_changes?
    (saved_changes.keys & VALUE_ATTRIBUTES).any? # & intersects the arrays
  end
end

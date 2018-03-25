class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validate :street_address_or_coordinates?

  with_options if: :any_street_address_fields? do
    validates :state,
              length: { is: 2 },
              format: {
                with: /\A[A-Z]+\z/,
                message: 'only allows uppercase letters'
              },
              allow_nil: true
    validates :zip,
              format: {
                with: /\A\d{5}(-\d{4})?\z/,
                message: 'must be of the format xxxxx or xxxxx-xxxx'
              },
              allow_nil: true
  end

  def any_street_address_fields?
    [street, city, state, zip].any?(&:present?)
  end

  def street_address_or_coordinates?
    # rubocop:disable Style/GuardClause
    unless enough_street_address_info? || both_coordinates?
      errors[:base] << <<~TEXT
        An address needs either a valid street address (a street plus zip or
        city and state) or a valid set of geographic coordinates (latitude and
        longitude).
      TEXT
    end
    # rubocop:enable Style/GuardClause
  end

  def enough_street_address_info?
    street.present? && ([city, state].all?(&:present?) || zip.present?)
  end

  def both_coordinates?
    [latitude, longitude].all?(&:present?)
  end
end

class Station < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :lat, presence: true,  numericality: true
end

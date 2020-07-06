class Expertise < ApplicationRecord
  has_many :trainers

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }, uniqueness: true
end

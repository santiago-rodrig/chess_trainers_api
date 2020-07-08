class AppointmentStatus < ApplicationRecord
  has_many :appointments

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }, uniqueness: true
end

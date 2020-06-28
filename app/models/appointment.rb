class Appointment < ApplicationRecord
  belongs_to :trainer
  belongs_to :appointment_status
  belongs_to :user
  scope :buffer, -> (number) { offset(4 * number).first(4) }
end

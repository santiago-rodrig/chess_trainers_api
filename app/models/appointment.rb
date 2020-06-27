class Appointment < ApplicationRecord
  belongs_to :trainer
  belongs_to :appointment_status
  scope :buffer, -> (number) { offset(4 * number).first(4) }
end

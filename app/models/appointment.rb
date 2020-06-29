class Appointment < ApplicationRecord
  belongs_to :trainer
  belongs_to :appointment_status
  belongs_to :user
  scope :buffer, -> (number, user) { where(user: user).offset(4 * number).first(4) }
end

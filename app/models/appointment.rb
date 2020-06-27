class Appointment < ApplicationRecord
  belongs_to :trainer
  belongs_to :appointment_status
end

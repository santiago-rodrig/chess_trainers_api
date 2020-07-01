class Appointment < ApplicationRecord
  belongs_to :trainer
  belongs_to :appointment_status
  belongs_to :user

  scope :filtered, -> (filters) do
    trainers = Trainer.where('name LIKE ?', "%#{filters[:tname]}%")
    where(trainer: trainers)
  end

  scope :buffer, -> (number, user, filters) do
    pending = AppointmentStatus.find_by(name: 'pending')
    success = AppointmentStatus.find_by(name: 'success')
    failed = AppointmentStatus.find_by(name: 'failed')
    data = filtered(filters).where(user: user)
    pending_data = data.where(appointment_status: pending).order('created_at DESC').to_a
    success_data = data.where(appointment_status: success).order('created_at DESC').to_a
    failed_data = data.where(appointment_status: failed).order('created_at DESC').to_a
    data = pending_data + success_data + failed_data
    [data[(4 * number), 4], failed_data[-1] == data[(4 * number), 4][-1]]
  end
end

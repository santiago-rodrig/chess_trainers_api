class Appointment < ApplicationRecord
  belongs_to :trainer
  belongs_to :appointment_status
  belongs_to :user

  scope :filtered, -> (filters) do
    trainers = Trainer.where('name LIKE ?', "%#{filters[:tname]}%")
    pending = AppointmentStatus.find_by(name: 'pending')
    success = AppointmentStatus.find_by(name: 'success')
    failed = AppointmentStatus.find_by(name: 'failed')
    data = where(trainer: trainers)

    case filters[:status].to_i(2)
    when 7
      # 111 -> pending, success, and failed
      # do nothing
    when 6
      # 110 -> pending and success
      data = data.where.not(appointment_status: failed)
    when 5
      # 101 -> pending and failed
      data = data.where.not(appointment_status: success)
    when 4
      # 100 -> pending only
      data = data.where(appointment_status: pending)
    when 3
      # 011 -> success and failed
      data = data.where.not(appointment_status: pending)
    when 2
      # 010 -> success only
      data = data.where(appointment_status: success)
    when 1
      # 001 -> failed only
      data = data.where(appointment_status: failed)
    when 0
      # 000 -> none
      data = data.where(id: nil)
    end

    data
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

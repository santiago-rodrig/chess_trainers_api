class Appointment < ApplicationRecord
  belongs_to :trainer
  belongs_to :appointment_status
  belongs_to :user

  scope :filtered, lambda { |filters|
    trainers = Trainer.where('name LIKE ?', "%#{filters[:tname]}%")
    pending = AppointmentStatus.find_by(name: 'pending')
    success = AppointmentStatus.find_by(name: 'success')
    failed = AppointmentStatus.find_by(name: 'failed')
    data = where(trainer: trainers)

    case filters[:status].to_i(2)
    when 6
      data = data.where.not(appointment_status: failed)
    when 5
      data = data.where.not(appointment_status: success)
    when 4
      data = data.where(appointment_status: pending)
    when 3
      data = data.where.not(appointment_status: pending)
    when 2
      data = data.where(appointment_status: success)
    when 1
      data = data.where(appointment_status: failed)
    when 0
      data = data.where(id: nil)
    end

    data
  }

  scope :buffer, lambda { |number, user, filters|
    pending = AppointmentStatus.find_by(name: 'pending')
    success = AppointmentStatus.find_by(name: 'success')
    failed = AppointmentStatus.find_by(name: 'failed')
    data = filtered(filters).where(user: user)
    pending_data = data.where(appointment_status: pending).order('created_at DESC').to_a
    success_data = data.where(appointment_status: success).order('created_at DESC').to_a
    failed_data = data.where(appointment_status: failed).order('created_at DESC').to_a
    data = pending_data + success_data + failed_data
    collection = data[(4 * number), 4]
    last_group = collection.any? { |appointment| data.reverse[0, 4].include?(appointment) }
    [collection, last_group]
  }
end

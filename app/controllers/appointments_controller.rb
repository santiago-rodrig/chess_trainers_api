class AppointmentsController < ApplicationController
  def index
    user = User.find_by(token: get_token(request.headers['Authorization']))
    @appointments = Appointment.buffer(params[:number].to_i, user)
    @last_group = @appointments.last == Appointment.where(user: user).last
  end

  def create
    if data = is_data_valid?(params[:token], params[:trainer])
      if Appointment.create(data)
        AppointmentsMailer.with(trainer: data[:trainer], user: data[:user]).notify_creation.deliver_later
        head :ok
      else
        head :internal_server_error
      end
    else
      head :conflict
    end
  end

  private

  def get_token(authorization)
    authorization[7...]
  end

  def is_data_valid?(user_token, trainer_name)
    user = User.find_by(token: user_token)
    trainer = Trainer.find_by(name: trainer_name)
    status = AppointmentStatus.find_by(name: 'pending')
    user && trainer && { user: user, trainer: trainer, appointment_status: status }
  end
end

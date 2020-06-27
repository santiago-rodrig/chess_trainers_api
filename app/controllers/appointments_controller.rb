class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.buffer(params[:number].to_i)
    @last_group = @appointments.last == Appointment.last
  end
end

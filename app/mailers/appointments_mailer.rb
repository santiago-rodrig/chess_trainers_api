class AppointmentsMailer < ApplicationMailer
  def notify_creation
    @trainer = params[:trainer]
    mail(to: 'santo1996.29@gmail.com', subject: 'Chess Trainer Appointment')
  end
end

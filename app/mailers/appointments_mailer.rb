class AppointmentsMailer < ApplicationMailer
  def notify_creation
    @trainer = params[:trainer]
    @user = params[:user]
    mail(to: @user.email, subject: 'Chess Trainer Appointment')
  end
end

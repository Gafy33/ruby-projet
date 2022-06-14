class ReservationMailer < ApplicationMailer
  default from: 'no_reply@titre.com'

  def welcome_email
    @user = params[:user]
    @billet = params[:billet]
    @url  = 'http://0.0.0.0:3000/reservations/confirmations/' + @billet
    mail(to: @user.email, subject: 'Confirmation de votre réservation')
  end
end

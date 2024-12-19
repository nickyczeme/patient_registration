class PatientMailer < ApplicationMailer
  default from: 'default@example.com'

  def confirmation_email
    @patient = params[:patient]
    mail(to: @patient.email, subject: 'Registration Confirmation')
  end
end

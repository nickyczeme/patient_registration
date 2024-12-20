module Api
  module V1
    class PatientsController < ApplicationController

      def create
        patient = Patient.new(patient_params)

        if patient.save
          PatientMailer.with(patient: patient).confirmation_email.deliver_later
          SmsNotificationService.send_sms(patient.phone, "Hello #{patient.name}! Thank you for registering.")
          render json: patient, status: :created
        else
          render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def patient_params
        params.permit(:name, :email, :phone, :document_photo)
      end      
    end
  end
end

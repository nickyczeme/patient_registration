module Api
  module V1
    class PatientsController < ApplicationController

      def create
        patient = Patient.new(patient_params)

        if patient.save
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

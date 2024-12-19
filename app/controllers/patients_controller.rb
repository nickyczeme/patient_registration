class PatientsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    patient = Patient.new(patient_params)
    if patient.save
      render json: patient, status: :created
    else
      render json: patient.errors, status: :unprocessable_entity
    end
  end

  private

  def patient_params
    params.permit(:name, :email, :phone, document_photo: [])
  end
end
class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_patient, only: [:show, :edit]

  def new
    @patient = AthenaHealth::Patient.new
  end

  def create
    @patient = AthenaHealth::Patient.new(patient_params)

    response = athena_health_client.create_patient(
      practice_id: params[:practice_id],
      department_id: params[:department_id],
      params: patient_params
    )

    if response.is_a?(Hash) && response['error'].present?
      @errors = response
      render :new
    else
      redirect_to practice_department_path(params[:practice_id], params[:department_id]), notice: 'Patient created'
    end
  end

  def update
    @patient = AthenaHealth::Patient.new(patient_params)

    response = athena_health_client.update_patient(
      practice_id: params[:practice_id],
      patient_id: params[:id],
      params: patient_params
    )

    if response.is_a?(Hash) && response['error'].present?
      @errors = response
      render :edit
    else
      redirect_to practice_department_path(params[:practice_id], params[:department_id]), notice: 'Patient updated'
    end
  end

  def destroy
    athena_health_client.delete_patient(practice_id: params[:practice_id], patient_id: params[:id])
    redirect_to practice_department_path(params[:practice_id], params[:department_id]), notice: 'Patient destroyed'
  end

  private

  def find_patient
    @patient = athena_health_client.find_patient(
      practice_id: params[:practice_id],
      patient_id: params[:id]
    )
  end

  def patient_params
    params.require(:athena_health_patient).permit(:firstname, :lastname, :email, :departmentid, :dob)
  end
end

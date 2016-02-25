class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_patient, only: [:show, :edit, :invite]

  def index
    @patient_collection = athena_health_client.all_patients(
      practice_id: params[:practice_id],
      department_id: params[:department_id],
      params: { offset: params[:offset] }
    )
  end

  def new
    @patient = AthenaHealth::Patient.new
  end

  def create
    @patient = AthenaHealth::Patient.new(athena_health_patient_params)

    response = athena_health_client.create_patient(
      practice_id: params[:practice_id],
      department_id: params[:department_id],
      params: athena_health_patient_params
    )

    if response.is_a?(Hash) && response['error'].present?
      @errors = response
      render :new
    else
      redirect_to practice_department_patients_path(
        params[:practice_id],
        params[:department_id]
      ), notice: 'Patient created'
    end
  end

  def update
    @patient = AthenaHealth::Patient.new(athena_health_patient_params)

    response = athena_health_client.update_patient(
      practice_id: params[:practice_id],
      patient_id: params[:id],
      params: athena_health_patient_params
    )

    if response.is_a?(Hash) && response['error'].present?
      @errors = response
      render :edit
    else
      redirect_to practice_department_patients_path(
        params[:practice_id],
        params[:department_id]
      ), notice: 'Patient updated'
    end
  end

  def destroy
    athena_health_client.delete_patient(
      practice_id: params[:practice_id],
      patient_id: params[:id]
    )

    redirect_to practice_department_path(
      params[:practice_id],
      params[:department_id]
    ), notice: 'Patient destroyed'
  end

  def invite
    InviteUserService.call(
      attributes: {
        email: @patient.email,
        name: @patient.fullname,
        patient_id: @patient.patientid,
        role: :patient
      },
      invited_by: current_user
    )

    redirect_to practice_department_patients_path(
      params[:practice_id],
      params[:department_id]
    ), notice: 'Patient invited'
  end

  private

  def find_patient
    @patient = athena_health_client.find_patient(
      practice_id: params[:practice_id],
      patient_id: params[:id]
    )
  end

  def athena_health_patient_params
    params.require(:athena_health_patient).permit(:firstname, :lastname, :email, :dob)
  end
end

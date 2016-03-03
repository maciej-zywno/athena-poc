class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_patient, only: [:show, :edit, :invite]

  def index
    authorize :patient

    @patient_collection = athena_health_client.all_patients(
      practice_id: params[:practice_id],
      department_id: params[:department_id],
      params: { offset: params[:offset] }
    )
  end

  def new
    authorize :patient

    @patient = AthenaHealth::Patient.new
  end

  def show
    authorize :patient
  end

  def create
    authorize :patient

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

  def edit
    authorize :patient
  end

  def update
    authorize :patient

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
    authorize :patient

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
    authorize :patient

    if User.find_by_patient_id(@patient.patientid)
      flash[:error] = 'Patient has been invited in the past'
    else
      invite_patient
      flash[:notice] = 'Patient invited'
    end

    redirect_to practice_department_patients_path(
      params[:practice_id],
      params[:department_id]
    )
  end

  private

  def find_patient
    @patient = athena_health_client.find_patient(
      practice_id: params[:practice_id],
      patient_id: params[:id]
    )
  end

  def invite_patient
    InviteUserService.call(
      attributes: {
        email: @patient.email,
        name: @patient.fullname,
        patient_id: @patient.patientid,
        role: :patient
      },
      invited_by: current_user
    )
  end

  def athena_health_patient_params
    params.require(:athena_health_patient).permit(:firstname, :lastname, :email, :dob)
  end
end

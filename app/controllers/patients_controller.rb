class PatientsController < ApplicationController
  before_action :authenticate_user!

  def show
    @patient = athena_health_client.find_patient(
      practice_id: params[:practice_id],
      patient_id: params[:id]
    )
  end

  def create
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

  def destroy
    athena_health_client.delete_patient(practice_id: params[:practice_id], patient_id: params[:id])
    redirect_to practice_department_path(params[:practice_id], params[:department_id]), notice: 'Patient destroyed'
  end

  private

  def patient_params
    params.require(:patient).permit(:firstname, :lastname, :email, :practiceid, :departmentid, :dob)
  end
end

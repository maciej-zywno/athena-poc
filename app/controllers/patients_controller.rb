class PatientsController < ApplicationController
  before_action :authenticate_user!

  def create
    patient = Patient.new(patient_params)
    if patient.create(connection: athena_connection, params: patient_params)
      redirect_to practice_department_path(params[:practice_id], params[:department_id]), notice: "Patient created"
    else
      render :new
    end
  end

  def destroy
    Patient.destroy(connection: athena_connection, practiceid: params[:practice_id], patientid: params[:id])
    redirect_to :back
  end

  private

  def patient_params
    params.require(:patient).permit(:firstname, :lastname, :email, :practiceid, :departmentid, :dob)
  end
end

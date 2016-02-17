class DepartmentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @department = athena_health_client.find_department(practice_id: params[:practice_id], department_id: params[:id])
    @patient_collection = athena_health_client.all_patients(practice_id: params[:practice_id], department_id: params[:id])
  end
end

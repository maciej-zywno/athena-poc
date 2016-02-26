class DepartmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @department_collection = athena_health_client.all_departments(
      practice_id: params[:practice_id],
      params: { limit: 10, offset: params[:offset] }
    )
  end

  def show
    @department = athena_health_client.find_department(
      practice_id: params[:practice_id],
      department_id: params[:id]
    )
  end
end

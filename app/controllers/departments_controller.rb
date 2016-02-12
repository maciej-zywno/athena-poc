class DepartmentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @department = Department.find(connection: athena_connection, practiceid: params[:practice_id], departmentid: params[:id])
  end
end

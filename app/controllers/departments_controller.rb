class DepartmentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @department = Department.find(connection: athena_connection, practiceid: params[:practice_id], departmentid: params[:id])
    @patients = @department.patients(connection: athena_connection, practiceid: params[:practice_id])
  end
end

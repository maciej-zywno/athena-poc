class PatientsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    Patient.destroy(connection: athena_connection, practiceid: params[:practice_id], patientid: params[:id])
    redirect_to :back
  end
end

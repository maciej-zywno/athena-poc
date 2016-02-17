class PracticesController < ApplicationController
  before_action :authenticate_user!

  def index
    @practice_collection = athena_health_client.all_practices
  end

  def show
    @practice = athena_health_client.find_practice(practice_id: params[:id])
    @department_collection = athena_health_client.all_departments(practice_id: params[:id])
  end
end

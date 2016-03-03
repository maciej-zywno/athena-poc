class PracticesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_practice, only: :show

  def index
    authorize :practice

    @practice_collection = athena_health_client.all_practices
  end

  def show
    authorize :practice
  end

  private

  def set_practice
    @practice = athena_health_client.find_practice(
      practice_id: params[:id]
    )
  end
end

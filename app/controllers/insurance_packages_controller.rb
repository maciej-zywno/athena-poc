class InsurancePackagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @top_insurance_collection = athena_health_client.top_insurance_packages(
      practice_id: params[:practice_id]
    )
  end
end

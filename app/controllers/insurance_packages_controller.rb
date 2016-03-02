class InsurancePackagesController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :insurance_package, :index?

    @top_insurance_collection = athena_health_client.top_insurance_packages(
      practice_id: params[:practice_id]
    )
  end
end

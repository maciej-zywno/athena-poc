class ProvidersController < ApplicationController
  before_action :authenticate_user!

  def index
    @provider_collection = athena_health_client.all_providers(
      practice_id: params[:practice_id],
      params: {
        offset: params[:offset],
        limit: 10
      }
    )
  end
end

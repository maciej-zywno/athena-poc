class ProvidersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_provider, only: :invite

  def index
    @provider_collection = athena_health_client.all_providers(
      practice_id: params[:practice_id],
      params: {
        offset: params[:offset],
        limit: 10
      }
    )
  end

  def invite
    InviteUserService.call(
      attributes: {
        email: invite_provider_params[:email],
        name: @provider.fullname,
        athena_provider_id: @provider.providerid,
        role: :doctor
      },
      invited_by: current_user
    )

    redirect_to practice_providers_path(
      params[:practice_id],
    ), notice: 'Provider invited'
  end

  private

  def set_provider
    @provider = athena_health_client.find_provider(
      practice_id: params[:practice_id],
      provider_id: params[:id]
    )
  end

  def invite_provider_params
    params.require(:invite_provider).permit(:email)
  end
end

class ProvidersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_provider, only: :invite

  def index
    authorize :provider

    @provider_collection = athena_health_client.all_providers(
      practice_id: params[:practice_id],
      params: {
        offset: params[:offset],
        limit: 10
      }
    )
  end

  def invite
    authorize :provider

    if User.find_by_athena_provider_id(@provider.providerid)
      flash[:error] = 'Provider has been invited in the past'
    else
      invite_provider
      flash[:notice] = 'Provider invited'
    end

    redirect_to practice_providers_path(
      params[:practice_id],
    )
  end

  private

  def set_provider
    @provider = athena_health_client.find_provider(
      practice_id: params[:practice_id],
      provider_id: params[:id]
    )
  end

  def invite_provider
    InviteUserService.call(
      attributes: {
        email: invite_provider_params[:email],
        name: @provider.fullname,
        athena_provider_id: @provider.providerid,
        role: :doctor
      },
      invited_by: current_user
    )
  end

  def invite_provider_params
    params.require(:invite_provider).permit(:email)
  end
end

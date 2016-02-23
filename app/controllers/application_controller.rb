class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private

  def athena_health_client
    @client ||= AthenaHealth::Client.new(
      version: 'preview1',
      key: current_user.athena_health_key,
      secret: current_user.athena_health_secret
    )
  end
end

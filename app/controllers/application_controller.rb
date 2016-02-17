class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def athena_health_client
    @client ||= AthenaHealth::Client.new(version: 'preview1', key: current_user.athena_id, secret: current_user.athena_secret)
  end
end

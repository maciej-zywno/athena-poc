class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  rescue_from Exception do |e|
    if /AthenaHealth/.match(e.class.to_s)
      code = AthenaHealth::Error::ERROR_TYPES.key(e.class)
      redirect_to "/#{code}.html"
    else
      raise e
    end
  end

  private

  def athena_health_client
    @client ||= AthenaHealth::Client.new(
      version: 'preview1',
      key: current_user.athena_health_key,
      secret: current_user.athena_health_secret
    )
  end
end

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

  rescue_from Pundit::NotAuthorizedError, with: :render_unathorized_error

  private

  def athena_health_client
    @client ||= AthenaHealth::Client.new(
      version: 'preview1',
      key: current_user.athena_health_key,
      secret: current_user.athena_health_secret
    )
  end

  def render_unathorized_error
    redirect_to '/401.html'
  end

  def oauth_app
    OauthApplication.find_by_uid(params[:client_id])
  end

  def oauth_app_redirect_url
    oauth_app.redirect_uri + "#state=#{params[:state]}&access_token=#{resource.token}&token_type=Bearer"
  end
end

class SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)

    @oauth_app = Doorkeeper::Application.find_by_uid(params[:client_id])

    yield resource if block_given?
    respond_with resource, location: redirect_url
  end

  protected

  def redirect_url
    if @oauth_app
      @oauth_app.redirect_uri + "#state=#{params[:state]}&access_token=#{resource.token}&token_type=Bearer"
    else
      after_sign_in_path_for(resource)
    end
  end
end
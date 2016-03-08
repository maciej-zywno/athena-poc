class SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)

    yield resource if block_given?
    respond_with resource, location: redirect_url
  end

  protected

  def redirect_url
    oauth_app ? oauth_app_redirect_url : after_sign_in_path_for(resource)
  end
end
class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)

      @oauth_app = Doorkeeper::Application.find_by_uid(params[:client_id])

      respond_with resource, location: redirect_url
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def redirect_url
    if @oauth_app
      @oauth_app.redirect_uri + "#state=#{params[:state]}&access_token=#{resource.token}&token_type=Bearer"
    else
      after_sign_up_path_for(resource)
    end
  end
end
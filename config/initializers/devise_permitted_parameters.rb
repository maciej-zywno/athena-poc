module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :athena_id, :athena_secret, :phone_number])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end

end

DeviseController.send :include, DevisePermittedParameters

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def athena_connection
    AthenaConnection.new('preview1', 'vnr5gy93grxh9ay5xhrzy6xm', 'uYUX8UZAMcPBbtN')
  end
end

class UberController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def handle
    client = Uber::Client.new do |config|
      config.server_token  = 'wk8nwLSCOQUMAKUbtSQYfISSk8yosMzDeB8RnHhN'
      config.client_id     = 'pDgNR8fvL2s3qarXh23IamF7zWTrtRCd'
      config.client_secret = 'wAC-f6nfNOrqoz-APF84lNL37R7eFCEM8tC6ORT4'
    end


    # render text: handle_alexa_request(request_body_parsed, AlexaRubykit.build_request(request_body_parsed))
  end

end


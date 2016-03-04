class Client
  def instance
    client = Uber::Client.new do |config|
      config.server_token  = 'wk8nwLSCOQUMAKUbtSQYfISSk8yosMzDeB8RnHhN'
      config.client_id     = 'pDgNR8fvL2s3qarXh23IamF7zWTrtRCd'
      config.client_secret = 'wAC-f6nfNOrqoz-APF84lNL37R7eFCEM8tC6ORT4'
    end
  end

end
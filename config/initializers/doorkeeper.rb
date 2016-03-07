Doorkeeper.configure do
  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end

  grant_flows %w(implicit authorization_code client_credentials)
end

Doorkeeper.configure do
  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end
end
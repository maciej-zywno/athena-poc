crumb :root do
  link 'Dashboard', '/'
end

crumb :practices do
  link 'Practices', practices_path
end

crumb :update_my_account do
  link 'Update my account', edit_user_registration_path
end
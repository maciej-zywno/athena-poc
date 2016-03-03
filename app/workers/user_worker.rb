class UserWorker
  include Sidekiq::Worker

  sidekiq_options queue: :process_answer, retry: false

  def perform
    User.find_or_create_by!(email: 'sidekiq@athena-poc.com') do |user|
      user.name = 'sidekiq user'
      user.password = 'abcd1234'
      user.password_confirmation = 'abcd1234'
      user.role = :doctor
    end
  end
end
class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:patient, :admin, :doctor]

  validates :name, presence: true

  before_create :generate_token

  def athena_health_key
    role != 'admin' ? invited_by.athena_id : athena_id
  end

  def athena_health_secret
    role != 'admin' ? invited_by.athena_secret : athena_secret
  end

  def treatments
    logger.info role
    case role
      when 'admin' then Treatment.all
      when 'user' then Treatment.where(patient_id: id)
      when 'doctor' then Treatment.where(doctor_id: id)
      else raise "the method is not implemented for '#{role}' role"
    end
  end

  private

  def generate_token
    self.token = loop do
      random_token = SecureRandom.hex(16)
      break random_token unless User.exists?(token: random_token)
    end
  end
end

class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin, :doctor]
  after_initialize :set_default_role, :if => :new_record?

  validates :name, presence: true

  def set_default_role
    self.role ||= :user
  end

  def athena_health_key
    role == 'user' ? invited_by.athena_id : athena_id
  end

  def athena_health_secret
    role == 'user' ? invited_by.athena_secret : athena_secret
  end

  def treatments
    case role
      when 'admin' then Treatment.all
      when 'user' then Treatment.where(patient_id: id)
      when 'doctor' then Treatment.where(doctor_id: id)
      else raise "the method is not implemented for '#{role}' role"
    end
  end
end

class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:patient, :admin, :doctor]

  validates :name, presence: true

  def treatments
    logger.info role
    case role
      when 'admin' then Treatment.all
      when 'user' then Treatment.where(patient_id: id)
      when 'doctor' then Treatment.where(doctor_id: id)
      else raise "the method is not implemented for '#{role}' role"
    end
  end
end

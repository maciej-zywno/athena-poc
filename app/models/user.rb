class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:patient, :admin, :doctor]

  validates :name, presence: true

  def games
    logger.info role
    case role
      when 'admin' then Game.all
      when 'user' then Game.where(patient_id: id)
      when 'doctor' then Game.where(doctor_id: id)
      else raise "the method is not implemented for '#{role}' role"
    end
  end
end

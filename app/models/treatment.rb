class Treatment < ActiveRecord::Base
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  belongs_to :doctor,  class_name: 'User', foreign_key: 'doctor_id'

  has_many :questions
end

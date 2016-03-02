class TreatmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case user.role
        when 'admin' then scope.all
        when 'patient' then scope.where(patient_id: user.id)
        when 'doctor' then scope.where(doctor_id: user.id)
      end
    end
  end

  def show?
    user.admin? || record.patient_id == user.id || record.doctor_id == user.id
  end
end

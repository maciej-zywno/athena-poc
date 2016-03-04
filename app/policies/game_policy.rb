class GamePolicy < ApplicationPolicy
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
    admin? || user.games.include?(record)
  end

  def new?
    (admin? || doctor?)
  end

  def edit?
    user.games.include?(record) && (admin? || doctor?)
  end

  def create?
    user.games.include?(record) && (admin? || doctor?)
  end

  def update?
    user.games.include?(record) && (admin? || doctor?)
  end

  def destroy?
    user.games.include?(record) && (admin? || doctor?)
  end

end

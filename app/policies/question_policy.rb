class QuestionPolicy < ApplicationPolicy
  def show?
    user.treatments.include?(record.treatment)
  end

  def new?
    user.treatments.include?(record.treatment) && (admin? || doctor?)
  end

  def edit?
    user.treatments.include?(record.treatment) && (admin? || doctor?)
  end

  def create?
    user.treatments.include?(record.treatment) && (admin? || doctor?)
  end

  def update?
    user.treatments.include?(record.treatment) && (admin? || doctor?)
  end

  def destroy?
    user.treatments.include?(record.treatment) && (admin? || doctor?)
  end
end

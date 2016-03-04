class QuestionPolicy < ApplicationPolicy
  def show?
    user.games.include?(record.game)
  end

  def new?
    user.games.include?(record.game) && (admin? || doctor?)
  end

  def edit?
    user.games.include?(record.game) && (admin? || doctor?)
  end

  def create?
    user.games.include?(record.game) && (admin? || doctor?)
  end

  def update?
    user.games.include?(record.game) && (admin? || doctor?)
  end

  def destroy?
    user.games.include?(record.game) && (admin? || doctor?)
  end
end

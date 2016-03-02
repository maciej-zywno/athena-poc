class ProviderPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def invite?
    user.admin?
  end
end

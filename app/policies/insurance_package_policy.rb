class InsurancePackagePolicy < ApplicationPolicy
  def index?
    user.admin?
  end
end

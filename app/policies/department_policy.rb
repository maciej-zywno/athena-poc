class DepartmentPolicy < ApplicationPolicy
  permit_admin_to :index, :show
end

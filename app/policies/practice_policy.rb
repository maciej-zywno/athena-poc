class PracticePolicy < ApplicationPolicy
  permit_admin_to :index, :show
end

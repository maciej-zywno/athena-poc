class ProviderPolicy < ApplicationPolicy
  permit_admin_to :index, :invite
end

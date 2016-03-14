class AppointmentPolicy < ApplicationPolicy
  permit_admin_to :new, :show, :update
end

class PatientPolicy < ApplicationPolicy
  permit_admin_to :index, :show, :new, :create, :edit, :invite, :update, :destroy
end

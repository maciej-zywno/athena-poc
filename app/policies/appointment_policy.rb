class AppointmentPolicy < ApplicationPolicy
  permit_patient_to :new, :show, :update
end

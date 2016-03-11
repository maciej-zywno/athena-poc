class AppointmentsController < ApplicationController
  include Wicked::Wizard

  steps :set_department_and_provider, :set_appointment_reason, :set_appointment_slot

  def show
    case step
    when :set_department_and_provider
      @providers = athena_health_client.all_providers(
        practice_id: params[:practice_id]
      ).providers

      @departments = athena_health_client.all_departments(
        practice_id: params[:practice_id]
      ).departments
    when :set_appointment_reason
      @patient_appointment_reasons = athena_health_client.all_patient_appointment_reasons(
        practice_id: params[:practice_id],
        department_id: params[:appointment][:department_id],
        provider_id: params[:appointment][:provider_id]
      ).patient_appointment_reasons

    when :set_appointment_slot
      @appointment_slots = athena_health_client.open_appointment_slots(
        practice_id: params[:practice_id],
        reason_id: params[:appointment][:patient_appointment_reason_id],
        provider_id: params[:provider_id],
        department_id: params[:department_id]
      ).appointments
    end

    render_wizard
  end

  def update
    athena_health_client.book_appointment(
      practice_id: params[:practice_id],
      reason_id: params[:patient_appointment_reason_id],
      patient_id: 1,
      appointment_id: params[:appointment][:appointment_id]
    )

    redirect_to root_path, notice: 'visit booked'
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :medical_records, :doctor_info, :create_patient_appointment, :appointments]

  def show
    @patients = Patient.all
    @doctors = Doctor.all
  end

  def medical_records
    @patients = Patient.all
    @doctors = Doctor.all
    if params[:patient_id].present?
      @selected_patient = Patient.find(params[:patient_id])
      @medical_records = @selected_patient.medical_records
    else
      @selected_patient = nil
      @medical_records = []
    end
    render :show
  end

  def doctor_info
    @patients = Patient.all
    @doctors = Doctor.all
    if params[:doctor_id].present?
      @selected_doctor = Doctor.find(params[:doctor_id])
      @doctor_hospital = @selected_doctor.hospital
    else
      @selected_doctor = nil
      @doctor_hospital = nil
    end
    render :show
  end

  def create_patient_appointment
    @patient = current_user.patient
    redirect_to new_appointment_path(patient_id: @patient.id)
  end

  def appointments
    @appointments = @user.patient.appointments
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

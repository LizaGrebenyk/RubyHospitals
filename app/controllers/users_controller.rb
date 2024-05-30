class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :medical_records, :doctor_info, :create_patient_appointment, :appointments]

  def show
    log_user_action('show')

    Rails.logger.debug '== Starting show action =='

    @patients = Patient.all
    @doctors = Doctor.all

    Rails.logger.debug "Found #{Patient.count} patients" if @patients
    Rails.logger.debug "Found #{Doctor.count} doctors" if @doctors

    unless @patients.present?
      Rails.logger.warn 'No patients found'
    end

    unless @doctors.present?
      Rails.logger.warn 'No doctors found'

      Rails.logger.debug '== Finished show action =='
    end
  end

  def medical_records
    log_user_action('medical_records')

    Rails.logger.debug '== Starting medical_records action =='

    @patients = Patient.all
    @doctors = Doctor.all

    Rails.logger.debug "Found #{Patient.count} patients" if @patients
    Rails.logger.debug "Found #{Doctor.count} doctors" if @doctors

    unless @patients.present?
      Rails.logger.warn 'No patients found'
    end

    unless @doctors.present?
      Rails.logger.warn 'No doctors found'
    end

    if params[:patient_id].present?
      @selected_patient = Patient.find(params[:patient_id])
      @medical_records = @selected_patient.medical_records
    else
      @selected_patient = nil
      @medical_records = []
    end

    Rails.logger.debug "Selected patient: #{@selected_patient&.name}"
    Rails.logger.debug "Found #{@medical_records&.count} medical records"

    Rails.logger.debug '== Finished medical_records action =='

    render :show
  end

  def doctor_info
    log_user_action('doctor_info')

    Rails.logger.debug '== Starting doctor_info action =='

    @patients = Patient.all
    @doctors = Doctor.all

    Rails.logger.debug "Found #{Patient.count} patients"
    Rails.logger.debug "Found #{Doctor.count} doctors"

    unless @patients.present?
      Rails.logger.warn 'No patients found'
    end

    unless @doctors.present?
      Rails.logger.warn 'No doctors found'
    end

    if params[:doctor_id].present?
      @selected_doctor = Doctor.find(params[:doctor_id])
      @doctor_hospital = @selected_doctor.hospital
    else
      @selected_doctor = nil
      @doctor_hospital = nil
    end

    Rails.logger.debug "Selected doctor: #{@selected_doctor&.name}, Hospital: #{@doctor_hospital&.title}"

    Rails.logger.debug '== Finished doctor_info action =='

    render :show
  end

  def create_patient_appointment
    log_user_action('create_patient_appointment')
    begin
      @patient = current_user.patient
      redirect_to new_appointment_path(patient_id: @patient.id)
    rescue => e
      Rails.logger.error "Error creating appointment for user with ID #{current_user&.id}"
      Rails.logger.error e.message
      redirect_back(fallback_location: root_path)
    end
  end

  def appointments
    log_user_action('appointments')
    begin
      @appointments = @user.patient.appointments
    rescue => e
      Rails.logger.error "Error fetching appointments for user with ID #{@user&.id}"
      Rails.logger.error e.message
      @appointments = []
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    Rails.logger.debug "User with ID #{params[:id]} was set."
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "User with ID #{params[:id]} not found."
    redirect_to root_path, alert: "User not found."
  end

  def log_user_action(action)
    Rails.logger.debug "User action '#{action}' performed by user with ID: #{current_user.id}"
  end
end
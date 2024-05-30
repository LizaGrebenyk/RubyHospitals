class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]
  before_action :set_logging_context

  # GET /patients or /patients.json
  def index
    @patients = Patient.all
    Rails.logger.debug " === Retrieved all patients from the database. === ", @patients_context  if @patients.any?
    Rails.logger.warn " === No patients found in the database. === ", @patients_context if @patients.empty?
  end

  # GET /patients/1 or /patients/1.json
  def show
    Rails.logger.debug " === Retrieved patient details for patient ID: #{params[:id]} === ", @patients_context
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    Rails.logger.debug " === Rendering form for creating a new patient. ===", @patients_context
  end

  # GET /patients/1/edit
  def edit
    Rails.logger.debug " === Rendering form for editing patient details for patient ID: #{params[:id]} ===", @patients_context
  end

  # POST /patients or /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to patient_url(@patient), notice: "Patient was successfully created." }
        format.json { render :show, status: :created, location: @patient }
        Rails.logger.info " === Patient with ID: #{params[:id]} was successfully created. ===", @patients_context
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
        Rails.logger.error " === Failed to create patient. Errors: #{@patient.errors} === ", @patients_context
      end
    end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patient_url(@patient), notice: "Patient was successfully updated." }
        format.json { render :show, status: :ok, location: @patient }
        Rails.logger.info " === Patient with ID: #{params[:id]} was successfully updated. ===", @patients_context
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
        Rails.logger.error " === Failed to update patient with ID: #{params[:id]}. Errors: #{@patient.errors} ===", @patients_context
      end
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to patients_url, notice: "Patient was successfully destroyed." }
      format.json { head :no_content }
      Rails.logger.info " === Patient with ID: #{params[:id]} was successfully destroyed. === ", @patients_context
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
    Rails.logger.debug " === Set patient with ID: #{params[:id]} for action. === ", @patients_context
  end

  # Only allow a list of trusted parameters through.
  def patient_params
    params.require(:patient).permit(:name, :gender, :date_of_birth)
  end

  def set_logging_context
    @patients_context = [controller: "PATIENTS"]
  end
end

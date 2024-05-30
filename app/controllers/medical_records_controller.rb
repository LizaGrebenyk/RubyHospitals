class MedicalRecordsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_medical_record, only: %i[ show edit update destroy ]

  # GET /medical_records or /medical_records.json
  def index
    @medical_records = MedicalRecord.all
    Rails.logger.debug "=== Fetched #{controller_name} records: #{@medical_records&.count} ==="
  rescue => e
    Rails.logger.error "=== Error occurred while fetching #{controller_name} records: #{e.message} ==="
  end

  # GET /medical_records/1 or /medical_records/1.json
  def show
    @medical_record = MedicalRecord.find(params[:id])
    Rails.logger.info "=== Medical record with ID #{params[:id]} was accessed. ==="
  end

  # GET /medical_records/new
  def new
    @medical_record = MedicalRecord.new
  end

  # GET /medical_records/1/edit
  def edit
  end

  # POST /medical_records or /medical_records.json
  def create
    @medical_record = MedicalRecord.new(medical_record_params)

    respond_to do |format|
      if @medical_record.save
        format.html { redirect_to medical_record_url(@medical_record), notice: "Medical record was successfully created." }
        format.json { render :show, status: :created, location: @medical_record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medical_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medical_records/1 or /medical_records/1.json
  def update
    respond_to do |format|
      if @medical_record.update(medical_record_params)
        format.html { redirect_to medical_record_url(@medical_record), notice: "Medical record was successfully updated." }
        format.json { render :show, status: :ok, location: @medical_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @medical_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medical_records/1 or /medical_records/1.json
  def destroy
    @medical_record.destroy

    respond_to do |format|
      format.html { redirect_to medical_records_url, notice: "Medical record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_medical_record
    @medical_record = MedicalRecord.find(params[:id])
    Rails.logger.debug "=== Medical record with ID #{params[:id]} was found. ===" if @medical_record
    raise ActiveRecord::RecordNotFound, "=== Medical record with ID #{params[:id]} not found ===" unless @medical_record
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error e.message
    redirect_to medical_records_url, alert: e.message
  rescue => e
    Rails.logger.error "=== Error occurred while finding medical record: #{e.message} ==="
    redirect_to medical_records_url, alert: "An error occurred while finding medical record"
  end

    # Only allow a list of trusted parameters through.
    def medical_record_params
      params.require(:medical_record).permit(:doctor_id, :patient_id, :date, :diagnosis, :treatment)
    end
end

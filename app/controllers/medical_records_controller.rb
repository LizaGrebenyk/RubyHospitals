class MedicalRecordsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_medical_record, only: %i[ show edit update destroy ]

  # GET /medical_records or /medical_records.json
  def index
    @medical_records = MedicalRecord.all
  end

  # GET /medical_records/1 or /medical_records/1.json
  def show
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
    end

    # Only allow a list of trusted parameters through.
    def medical_record_params
      params.require(:medical_record).permit(:doctor_id, :patient_id, :date, :diagnosis, :treatment)
    end
end

class HospitalsController < ApplicationController
  before_action :set_hospital, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:index]

  # GET /hospitals or /hospitals.json
  def index
    if params[:search].present?
      @hospitals = HospitalSearchQuery.new(params[:search]).call
    else
      @hospitals = Hospital.all
    end
    Rails.logger.info "==== Fetched #{@hospitals&.count} hospitals ===="
  rescue => e
    Rails.logger.error "==== Error occurred while fetching hospitals: #{e.message} ===="
  end

  # GET /hospitals/1 or /hospitals/1.json
  def show
    Rails.logger.info "==== Showing details for hospital with ID: #{params[:id]} ===="
  rescue => e
    Rails.logger.error "==== Error occurred while showing hospital details: #{e.message} ===="
  end

  # GET /hospitals/new
  def new
    @hospital = Hospital.new
  end

  # GET /hospitals/1/edit
  def edit
  end

  # POST /hospitals or /hospitals.json
  def create
    @hospital = Hospital.new(hospital_params)

    respond_to do |format|
      if @hospital.save
        format.html { redirect_to hospital_url(@hospital), notice: "Hospital was successfully created." }
        format.json { render :show, status: :created, location: @hospital }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hospitals/1 or /hospitals/1.json
  def update
    respond_to do |format|
      if @hospital.update(hospital_params)
        format.html { redirect_to hospital_url(@hospital), notice: "Hospital was successfully updated." }
        format.json { render :show, status: :ok, location: @hospital }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hospitals/1 or /hospitals/1.json
  def destroy
    @hospital.destroy

    respond_to do |format|
      format.html { redirect_to hospitals_url, notice: "Hospital was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital
      @hospital = Hospital.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hospital_params
      params.require(:hospital).permit(:title, :country, :city, :telephone)
    end
end

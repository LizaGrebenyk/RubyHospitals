class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :medical_records]

  def show
    @patients = Patient.all
  end

  def medical_records
    @patients = Patient.all
    if params[:patient_id].present?
      @selected_patient = Patient.find(params[:patient_id])
      @medical_records = @selected_patient.medical_records
    else
      @selected_patient = nil
      @medical_records = []
    end
    render :show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

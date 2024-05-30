json.extract! medical_record, :id, :doctor_id, :patient_id, :date, :diagnosis, :treatment, :created_at, :updated_at
json.url medical_record_url(medical_record, format: :json)

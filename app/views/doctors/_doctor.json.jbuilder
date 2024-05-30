json.extract! doctor, :id, :hospital_id, :name, :specialization, :phone_number, :created_at, :updated_at
json.url doctor_url(doctor, format: :json)

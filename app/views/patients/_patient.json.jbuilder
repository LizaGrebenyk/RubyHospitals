json.extract! patient, :id, :name, :gender, :date_of_birth, :created_at, :updated_at
json.url patient_url(patient, format: :json)

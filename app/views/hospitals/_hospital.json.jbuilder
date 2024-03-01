json.extract! hospital, :id, :name, :country, :city, :phone_number, :created_at, :updated_at
json.url hospital_url(hospital, format: :json)

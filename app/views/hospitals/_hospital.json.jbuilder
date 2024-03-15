json.extract! hospital, :id, :title, :country, :city, :telephone, :created_at, :updated_at
json.url hospital_url(hospital, format: :json)

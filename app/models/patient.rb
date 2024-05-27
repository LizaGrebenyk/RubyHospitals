class Patient < ApplicationRecord
  has_many :medical_records
end

class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :medical_records
end

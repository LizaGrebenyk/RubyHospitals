class Patient < ApplicationRecord
  belongs_to :user, optional: true
  has_many :appointments
  has_many :medical_records
end

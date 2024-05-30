require 'faker'

MEDICAL_SPECIALIZATIONS = [
  'Gastroenterologist',
  'Cardiologist',
  'Neurologist',
  'Orthopedic Surgeon',
  'Pediatrician',
  'Dermatologist',
  'Oncologist',
  'Psychiatrist',
  'Endocrinologist',
  'Radiologist',
  'Ophthalmologist',
  'Pulmonologist',
  'Nephrologist'
]

namespace :db do
  desc "Generate 100 doctors with emails from domain karazin.ua"
  task :generate_doctors => :environment do
    100.times do
      name = Faker::Name.name
      doctor = Doctor.new(
        hospital_id: Hospital.pluck(:id).sample,
        name: name,
        specialization: MEDICAL_SPECIALIZATIONS.sample,
        phone_number: Faker::PhoneNumber.cell_phone_in_e164,
        email: "#{name.gsub(' ', '.').gsub('..', '.').downcase}@karazin.ua" # or Faker::Internet.email(domain: 'karazin.ua')
      )
      if doctor.save
        puts "Created doctor: #{doctor.name}, #{doctor.hospital.title}, #{doctor.specialization}, #{doctor.phone_number}, email: #{doctor.email}"
      else
        puts "Failed to create doctor: #{doctor.errors.full_messages.join(', ')}"
      end
    end
  end
end
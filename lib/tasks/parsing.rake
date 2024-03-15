namespace :data_processing do

  task parse: :parse_data
  task save_db: :save_csv_data_in_db

  desc "Parse data and output to CSV"
  task :parse_data do
    csv_file = File.join(File.dirname(__FILE__), '../assets', 'hospitals.csv')
    script = File.join(File.dirname(__FILE__), '..', 'parsing_script.rb')
      
    unless File.exist?(csv_file)
      system("ruby #{script}")
    end
  end

  desc "Read CSV data and save in the database"
  task :save_csv_data_in_db => :environment do
    require 'csv'
    require 'faker'

    csv_file = File.join(File.dirname(__FILE__), '../assets', 'hospitals.csv')

    # Прочитати дані з CSV файлу
    CSV.foreach(csv_file, headers: true) do |row|
      # Створити об'єкт моделі Hospital і заповнити його поля з рядка CSV
      hospital = Hospital.create(
        title: row['Publication name'],
        country: row['Country'],
        city: row['City'],
        telephone: Faker::PhoneNumber.cell_phone_in_e164
      )
    end
  end

  desc "Parse data and save in the database"
  task :all => [:parse_data, :save_csv_data_in_db]
end

require 'rails_helper'
require 'rake'
require 'fileutils'
require 'csv'

RSpec.describe 'data_processing rake tasks', type: :task do
  before :all do
    Rails.application.load_tasks if Rake::Task.tasks.empty?
  end

  describe 'data_processing:parse_data' do
    let(:csv_path) { Rails.root.join('lib', 'assets', 'hospitals.csv') }
    let(:test_csv_path) { Rails.root.join('spec', 'fixtures', 'test_hospitals.csv') }

    before(:each) do
      Appointment.delete_all
      MedicalRecord.delete_all
      Doctor.delete_all
      Hospital.delete_all
      FileUtils.cp(csv_path, test_csv_path)
      Rake::Task['data_processing:parse_data'].reenable
      Rake::Task['data_processing:save_csv_data_in_db'].reenable
    end

    after(:each) do
      FileUtils.rm(test_csv_path)
    end

    it 'parses and saves data correctly from the CSV file' do
      expect(Hospital.count).to eq(0)

      Rake::Task['data_processing:save_csv_data_in_db'].invoke(test_csv_path.to_s)

      csv_content = CSV.read(test_csv_path, headers: true)
      expect(Hospital.count).to eq(csv_content.count)

      hospital = Hospital.find_by(title: 'Apollo Hospital - Chennai')
      expect(hospital).not_to be_nil
      expect(hospital.title).to eq('Apollo Hospital - Chennai')
      expect(hospital.country).to eq('India')
      expect(hospital.city).to eq('Chennai')
    end
  end
end

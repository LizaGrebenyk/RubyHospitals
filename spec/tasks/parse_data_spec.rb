require 'rails_helper'
require 'rake'
require 'fileutils'
require 'csv'

RSpec.describe 'data_processing rake tasks', type: :task do
  before :all do
    Rails.application.load_tasks if Rake::Task.tasks.empty?
  end

  describe 'data_processing:parse_data' do
    let(:original_csv_path) { Rails.root.join('lib', 'assets', 'hospitals.csv') }
    let(:test_csv_path) { Rails.root.join('spec', 'fixtures', 'test_hospitals.csv') }

    before(:each) do
      FileUtils.cp(original_csv_path, test_csv_path)
    end

    after(:each) do
      FileUtils.rm(test_csv_path)
    end

    it 'creates CSV file with hospital data' do
      Rake::Task['data_processing:parse_data'].invoke

      expect(File).to exist(test_csv_path)

      csv_content = CSV.read(test_csv_path)
      expect(csv_content.size).to eq(251)

      Rake::Task['data_processing:parse_data'].reenable
    end
  end
end

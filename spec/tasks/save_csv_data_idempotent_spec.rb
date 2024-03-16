RSpec.describe 'data_processing rake tasks', type: :task do
  before :all do
    Rails.application.load_tasks if Rake::Task.tasks.empty?
  end

  describe 'data_processing:save_csv_data_in_db' do
    let(:csv_path) { Rails.root.join('spec', 'fixtures', 'test_hospitals.csv') }

    before(:each) do
      Hospital.delete_all
      Rake::Task['data_processing:save_csv_data_in_db'].invoke(csv_path.to_s)
    end

    it 'is idempotent' do
      expect {
        Rake::Task['data_processing:save_csv_data_in_db'].invoke(csv_path.to_s)
      }.to_not change(Hospital, :count)
    end
  end
end

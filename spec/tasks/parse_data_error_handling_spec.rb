RSpec.describe 'data_processing rake tasks', type: :task do
  before :all do
    Rails.application.load_tasks if Rake::Task.tasks.empty?
  end

  describe 'data_processing:parse_data' do
    it 'handles errors during parsing' do
      allow_any_instance_of(Object).to receive(:system).and_return(false)

      expect { Rake::Task['data_processing:parse_data'].invoke }.not_to raise_error

      csv_path = Rails.root.join('spec', 'fixtures', 'test_hospitals.csv')
      expect(File).not_to exist(csv_path)
    end
  end
end

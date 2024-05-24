require 'rails_helper'

RSpec.describe HospitalSearchQuery, type: :model do
  describe '#call' do
    let!(:hospital1) { Hospital.create(title: 'Saint Mary', country: 'USA', city: 'New York', telephone: '123456789') }
    let!(:hospital2) { Hospital.create(title: 'General Hospital', country: 'USA', city: 'Los Angeles', telephone: '987654321') }
    let!(:hospital3) { Hospital.create(title: 'Maryland Health Center', country: 'USA', city: 'Baltimore', telephone: '456123789') }

    it 'returns hospitals matching the search name' do
      result = HospitalSearchQuery.new('Mary').call
      expect(result).to include(hospital1, hospital3)
      expect(result).not_to include(hospital2)
    end

    it 'is case-insensitive' do
      result = HospitalSearchQuery.new('saint mary').call
      expect(result).to include(hospital1)
    end

    it 'returns an empty result when no match is found' do
      result = HospitalSearchQuery.new('No Match').call
      expect(result).to be_empty
    end
  end
end

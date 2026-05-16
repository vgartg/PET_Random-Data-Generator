# frozen_string_literal: true

RSpec.describe RandomDataGenerator::AddressGenerator do
  describe '.random_city' do
    it 'returns a city from the curated list' do
      expect(described_class::CITIES).to include(described_class.random_city)
    end
  end

  describe '.random_house_number' do
    it 'returns an integer in [1, 1000]' do
      number = described_class.random_house_number
      expect(number).to be_between(1, 1000).inclusive
    end
  end

  describe '.random_street_name' do
    it 'returns a street from the curated list' do
      expect(described_class::STREET_NAMES).to include(described_class.random_street_name)
    end
  end

  describe '.random_address' do
    it 'returns "<number> <street>, <city>"' do
      expect(described_class.random_address).to match(/^\d+ .+, .+$/)
    end
  end

  describe '.random_coordinates' do
    it 'returns valid latitude and longitude' do
      latitude, longitude = described_class.random_coordinates
      expect(latitude).to be_between(-90.0, 90.0).inclusive
      expect(longitude).to be_between(-180.0, 180.0).inclusive
    end
  end
end

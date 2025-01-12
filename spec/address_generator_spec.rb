# frozen_string_literal: true

# Load necessary modules
require_relative '../lib/address_generator'
require 'date'

RSpec.describe RandomDataGenerator::AddressGenerator do
  describe '.random_city' do
    it 'generates a random city' do
      expect(described_class::CITIES).to include(described_class.random_city)
    end
  end

  describe '.random_house_number' do
    it 'generates a random house number' do
      house_number = described_class.random_house_number
      expect(house_number).to be >= 1
      expect(house_number).to be <= 1000
    end
  end

  describe '.random_street_name' do
    it 'generates a random street name' do
      expect(described_class::STREET_NAMES).to include(described_class.random_street_name)
    end
  end

  describe ".random_address" do
    it "generates a random address" do
      address = RandomDataGenerator::AddressGenerator.random_address
      expect(address).to match(/^\d+ .+, .+$/)
    end
  end

  describe '.random_coordinates' do
    it 'generates random coordinates on Earth' do
      latitude, longitude = described_class.random_coordinates
      expect(latitude).to be >= -90.0
      expect(latitude).to be <= 90.0
      expect(longitude).to be >= -180.0
      expect(longitude).to be <= 180.0
    end
  end
end
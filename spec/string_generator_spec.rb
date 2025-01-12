# frozen_string_literal: true

# Load necessary modules
require_relative '../lib/string_generator'
require 'date'

RSpec.describe RandomDataGenerator::StringGenerator do
  describe '.random_string' do
    it 'generates a random string of specified length' do
      length = 10
      expect(RandomDataGenerator::StringGenerator.random_string(length).length).to eq(length)
    end
  end

  describe '.random_alpha_numeric_string' do
    it 'generates a random alpha-numeric string of specified length' do
      length = 10
      expect(RandomDataGenerator::StringGenerator.random_alpha_numeric_string(length)).to match(/^[a-zA-Z0-9]{#{length}}$/)
    end
  end

  describe '.random_letter_string' do
    it 'generates a random letter string of specified length' do
      length = 10
      expect(RandomDataGenerator::StringGenerator.random_letter_string(length)).to match(/^[a-zA-Z]{#{length}}$/)
    end
  end
end

# frozen_string_literal: true

# Load necessary modules
require_relative '../lib/random_data_generator/other_generator'
require 'date'

RSpec.describe RandomDataGenerator::OtherGenerator do
  describe '.random_text_description' do
    it 'generates a random text description' do
      description = RandomDataGenerator::OtherGenerator.random_text_description
      expect(description).to be_a(String)
      expect(description).not_to be_empty
    end
  end

  describe '.random_number' do
    it 'generates a random number within the specified range' do
      min = 1
      max = 100
      number = RandomDataGenerator::OtherGenerator.random_number(min, max)
      expect(number).to be >= min
      expect(number).to be <= max
    end
  end

  describe '.random_date' do
    it 'generates a random date within the specified range' do
      start_date = Date.new(2020, 1, 1)
      end_date = Date.new(2025, 12, 31)
      date = RandomDataGenerator::OtherGenerator.random_date(start_date, end_date)
      expect(date).to be >= start_date
      expect(date).to be <= end_date
    end
  end

  describe '.random_color' do
    it 'generates a random color' do
      color = RandomDataGenerator::OtherGenerator.random_color
      expect(color).to match(/^#[0-9A-F]{6}$/i)
    end
  end
end

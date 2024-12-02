# frozen_string_literal: true

require 'random_data_generator'
require 'date'

RSpec.describe RandomDataGenerator do
  describe '.random_string' do
    it 'generates a random string of specified length' do
      length = 10
      expect(RandomDataGenerator.random_string(length).length).to eq(length)
    end
  end

  describe '.random_number' do
    it 'generates a random number within the specified range' do
      min = 1
      max = 100
      number = RandomDataGenerator.random_number(min, max)
      expect(number).to be >= min
      expect(number).to be <= max
    end
  end

  describe '.random_date' do
    it 'generates a random date within the specified range' do
      start_date = Date.new(2020, 1, 1)
      end_date = Date.new(2025, 12, 31)
      date = RandomDataGenerator.random_date(start_date, end_date)
      expect(date).to be >= start_date
      expect(date).to be <= end_date
    end
  end
end

RSpec.describe RandomDataGenerator do
  describe '.random_alpha_numeric_string' do
    it 'generates a random alpha-numeric string of specified length' do
      length = 10
      expect(RandomDataGenerator.random_alpha_numeric_string(length)).to match(/^[a-zA-Z0-9]{#{length}}$/)
    end
  end

  describe '.random_letter_string' do
    it 'generates a random letter string of specified length' do
      length = 10
      expect(RandomDataGenerator.random_letter_string(length)).to match(/^[a-zA-Z]{#{length}}$/)
    end
  end

  describe '.random_ip_address' do
    it 'generates a random IP address' do
      ip_address = RandomDataGenerator.random_ip_address
      expect(ip_address).to match(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/)
    end
  end

  describe '.random_email' do
    it 'generates a random email address' do
      email = RandomDataGenerator.random_email
      expect(email).to match(/^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/)
    end
  end
end

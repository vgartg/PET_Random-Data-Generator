# frozen_string_literal: true

# Load necessary modules
require_relative '../lib/address_generator'
require_relative '../lib/other_generator'
require_relative '../lib/social_generator'
require_relative '../lib/string_generator'
require 'date'

RSpec.describe StringGenerator do
  describe '.random_string' do
    it 'generates a random string of specified length' do
      length = 10
      expect(StringGenerator.random_string(length).length).to eq(length)
    end
  end

  describe '.random_alpha_numeric_string' do
    it 'generates a random alpha-numeric string of specified length' do
      length = 10
      expect(StringGenerator.random_alpha_numeric_string(length)).to match(/^[a-zA-Z0-9]{#{length}}$/)
    end
  end

  describe '.random_letter_string' do
    it 'generates a random letter string of specified length' do
      length = 10
      expect(StringGenerator.random_letter_string(length)).to match(/^[a-zA-Z]{#{length}}$/)
    end
  end
end

RSpec.describe OtherGenerator do
  describe '.random_text_description' do
    it 'generates a random text description' do
      description = OtherGenerator.random_text_description
      expect(description).to be_a(String)
      expect(description).not_to be_empty
    end
  end

  describe '.random_number' do
    it 'generates a random number within the specified range' do
      min = 1
      max = 100
      number = OtherGenerator.random_number(min, max)
      expect(number).to be >= min
      expect(number).to be <= max
    end
  end

  describe '.random_date' do
    it 'generates a random date within the specified range' do
      start_date = Date.new(2020, 1, 1)
      end_date = Date.new(2025, 12, 31)
      date = OtherGenerator.random_date(start_date, end_date)
      expect(date).to be >= start_date
      expect(date).to be <= end_date
    end
  end

  describe '.random_color' do
    it 'generates a random color' do
      color = OtherGenerator.random_color
      expect(color).to match(/^#[0-9A-F]{6}$/i)
    end
  end
end

RSpec.describe SocialGenerator do
  describe '.random_email' do
    it 'generates a random email address' do
      email = SocialGenerator.random_email
      expect(email).to match(/^\w{8}@[a-zA-Z]+\.(com|net|org|co\.uk)$/)
    end
  end

  describe '.random_ip_address' do
    it 'generates a random IP address' do
      ip_address = SocialGenerator.random_ip_address
      expect(ip_address).to match(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/)
    end
  end

  describe '.random_phone_number' do
    it 'generates a random phone number' do
      phone_number = SocialGenerator.random_phone_number
      expect(phone_number).to match(/^\+\d{1,3}-\d{3}-\d{3}-\d{4}$/)
    end
  end

  describe '.random_person_name' do
    it 'generates a random person name' do
      person_name = SocialGenerator.random_person_name
      expect(person_name).to be_a(String)
      expect(person_name).not_to be_empty
    end
  end

  describe '.random_animal_name' do
    it 'generates a random animal name' do
      animal_name = SocialGenerator.random_animal_name
      expect(animal_name).to be_a(String)
      expect(animal_name).not_to be_empty
    end
  end

  describe '.random_company_name' do
    it 'generates a random company name' do
      company_name = SocialGenerator.random_company_name
      expect(company_name).to be_a(String)
      expect(company_name).not_to be_empty
    end
  end

  describe '.random_url' do
    it 'generates a random URL' do
      url = SocialGenerator.random_url
      expect(url).to match(%r{^https?://[^\s/$.?#].[^\s]*$})
    end
  end
end

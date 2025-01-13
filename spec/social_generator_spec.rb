# frozen_string_literal: true

# Load necessary modules
require_relative '../lib/random_data_generator/social_generator'
require 'date'

RSpec.describe RandomDataGenerator::SocialGenerator do
  describe '.random_email' do
    it 'generates a random email address' do
      email = RandomDataGenerator::SocialGenerator.random_email
      expect(email).to match(/^\w{8}@[a-zA-Z]+\.(com|net|org|co\.uk)$/)
    end
  end

  describe '.random_ip_address' do
    it 'generates a random IP address' do
      ip_address = RandomDataGenerator::SocialGenerator.random_ip_address
      expect(ip_address).to match(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/)
    end
  end

  describe '.random_phone_number' do
    it 'generates a random phone number' do
      phone_number = RandomDataGenerator::SocialGenerator.random_phone_number
      expect(phone_number).to match(/^\+\d{1,3}-\d{3}-\d{3}-\d{4}$/)
    end
  end

  describe '.random_person_name' do
    it 'generates a random person name' do
      person_name = RandomDataGenerator::SocialGenerator.random_person_name
      expect(person_name).to be_a(String)
      expect(person_name).not_to be_empty
    end
  end

  describe '.random_animal_name' do
    it 'generates a random animal name' do
      animal_name = RandomDataGenerator::SocialGenerator.random_animal_name
      expect(animal_name).to be_a(String)
      expect(animal_name).not_to be_empty
    end
  end

  describe '.random_company_name' do
    it 'generates a random company name' do
      company_name = RandomDataGenerator::SocialGenerator.random_company_name
      expect(company_name).to be_a(String)
      expect(company_name).not_to be_empty
    end
  end

  describe '.random_url' do
    it 'generates a random URL' do
      url = RandomDataGenerator::SocialGenerator.random_url
      expect(url).to match(%r{^https?://[^\s/$.?#].[^\s]*$})
    end
  end
end
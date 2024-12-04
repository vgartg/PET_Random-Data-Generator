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
end

RSpec.describe RandomDataGenerator do
  describe '.random_date' do
    it 'generates a random date within the specified range' do
      start_date = Date.new(2020, 1, 1)
      end_date = Date.new(2025, 12, 31)
      date = RandomDataGenerator.random_date(start_date, end_date)
      expect(date).to be >= start_date
      expect(date).to be <= end_date
    end
  end

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
end

RSpec.describe RandomDataGenerator do
  describe '.random_ip_address' do
    it 'generates a random IP address' do
      ip_address = RandomDataGenerator.random_ip_address
      expect(ip_address).to match(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/)
    end
  end

  describe '.random_email' do
    it 'generates a random email address' do
      email = RandomDataGenerator.random_email
      expect(email).to match(/^\w+[._]?\w*@[a-zA-Z_]+\.[a-zA-Z_]+(\.[a-zA-Z]{2,4}){1,2}$/)
    end
  end
end

RSpec.describe RandomDataGenerator do
  describe '.random_company_name' do
    it 'generates a random company name' do
      company_name = RandomDataGenerator.random_company_name
      expect(company_name).to be_a(String)
      expect(company_name).not_to be_empty
    end
  end

  describe '.random_phone_number' do
    it 'generates a random phone number' do
      phone_number = RandomDataGenerator.random_phone_number
      expect(phone_number).to match(/^\+\d{1,3}-\d{3}-\d{3}-\d{4}$/)
    end
  end
end

RSpec.describe RandomDataGenerator do
  describe '.random_person_name' do
    it 'generates a random person name' do
      person_name = RandomDataGenerator.random_person_name
      expect(person_name).to be_a(String)
      expect(person_name).not_to be_empty
    end
  end

  describe '.random_animal_name' do
    it 'generates a random animal name' do
      animal_name = RandomDataGenerator.random_animal_name
      expect(animal_name).to be_a(String)
      expect(animal_name).not_to be_empty
    end
  end
end

RSpec.describe RandomDataGenerator do
  describe '.random_text_description' do
    it 'generates a random text description' do
      text_description = RandomDataGenerator.random_text_description
      expect(text_description).to be_a(String)
      expect(text_description).not_to be_empty
    end
  end
end

RSpec.describe RandomDataGenerator do
  describe '.random_url' do
    it 'generates a random URL' do
      url = RandomDataGenerator.random_url
      expect(url).to match(%r{^https?://[^\s/$.?#].[^\s]*$})
    end
  end

  describe '.random_color' do
    it 'generates a random color' do
      color = RandomDataGenerator.random_color
      expect(color).to match(/^#[0-9A-F]{6}$/i)
    end
  end
end

RSpec.describe RandomDataGenerator do
  describe '.random_coordinates' do
    it 'generates random coordinates on Earth' do
      latitude, longitude = RandomDataGenerator.random_coordinates
      expect(latitude).to be_within(90).of(0)
      expect(longitude).to be_within(180).of(0)
    end
  end
end

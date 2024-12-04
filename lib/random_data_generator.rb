# frozen_string_literal: true

# Module for generating random data.
module RandomDataGenerator
  # Generates a random string of specified length.
  def self.random_string(length)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a
    Array.new(length) { chars.sample }.join
  end

  # Generates a random number within the specified range.
  def self.random_number(min, max)
    rand(min..max)
  end

  # Generates a random date within the specified range.
  def self.random_date(start_date, end_date)
    rand(start_date..end_date)
  end

  # Generates a random alpha-numeric string of specified length.
  def self.random_alpha_numeric_string(length)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    Array.new(length) { chars.sample }.join
  end

  # Generates a random letter string of specified length.
  def self.random_letter_string(length)
    chars = ('a'..'z').to_a
    Array.new(length) { chars.sample }.join
  end

  # Generates a random IP address.
  def self.random_ip_address
    (1..4).map { rand(256) }.join('.')
  end

  # Generates a random email address.
  def self.random_email
    username = random_string(8)
    domain = %w[gmail.com yahoo.com outlook.com example.com].sample
    domain_extension = %w[com net org co.uk].sample
    "#{username}@#{domain}.#{domain_extension}"
  end

  # Generates random data for various purposes.
  class RandomDataGenerator
    # Method to load cities data from file
    def self.load_cities
      cities = []
      File.open('src/cities.txt', 'r') do |file|
        file.each_line do |line|
          line.split.each { |word| cities << word }
        end
      end
      cities.freeze
    end

    # Method to load street names data from file
    def self.load_street_names
      street_names = []
      File.open('src/street_names.txt', 'r') do |file|
        file.each_line do |line|
          line.split.each { |word| street_names << word }
        end
      end
      street_names.freeze
    end

    # Arrays to store cities and street names
    CITIES = load_cities
    STREET_NAMES = load_street_names

    # Method to generate a random city
    def self.random_city
      CITIES.sample
    end

    # Method to generate a random house number
    def self.random_house_number
      rand(1..1000)
    end

    # Method to generate a random street name
    def self.random_street_name
      STREET_NAMES.sample
    end

    # Method to generate a random address
    def self.random_address
      "#{random_house_number} #{random_street_name}, #{random_city}"
    end
  end

  # Generates a random company name.
  def self.random_company_name
    company_suffixes = %w[Inc Ltd LLC Corp Ltda SA]
    company_prefixes = %w[ABC XYZ Best First Global Smart]
    "#{company_prefixes.sample} #{company_suffixes.sample}"
  end

  # Generates a random phone number.
  def self.random_phone_number
    country_code = '+1' # Example country code
    "#{country_code}-#{rand(100..999)}-#{rand(100..999)}-#{rand(1000..9999)}"
  end

  # Generates a random person name.
  def self.random_person_name
    first_names = %w[John Jane Michael Sarah James Emily]
    last_names = %w[Smith Johnson Williams Jones Brown]
    "#{first_names.sample} #{last_names.sample}"
  end

  # Generates a random animal name.
  def self.random_animal_name
    animals = %w[Dog Cat Rabbit Bird Fish Elephant]
    "#{animals.sample}-#{rand(1000..9999)}"
  end

  # Generates a random text description.
  def self.random_text_description
    descriptions = File.readlines('src/descriptions.txt').map(&:strip)
    descriptions.sample
  end

  # Generates a random URL.
  def self.random_url
    schemes = %w[http https]
    extensions = %w[com net org edu gov]
    "#{schemes.sample}://www.example#{rand(100..999)}.#{extensions.sample}"
  end

  # Generates a random color.
  def self.random_color
    "##{rand(0..0xFFFFFF).to_s(16).rjust(6, '0')}"
  end

  # Generates random coordinates on Earth.
  def self.random_coordinates
    latitude = rand(-90.0..90.0)
    longitude = rand(-180.0..180.0)
    [latitude, longitude]
  end
end

# frozen_string_literal: true

module RandomDataGenerator
  module AddressGenerator
    # Method to read words from a file
    def self.read_words(file_path)
      File.readlines(file_path).flat_map { |line| line.split }
    end

    # Method to load cities data from file
    def self.load_cities
      read_words('resources/cities.txt').freeze
    end

    # Method to load street names data from file
    def self.load_street_names
      read_words('resources/street_names.txt').freeze
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

    # Generates random coordinates on Earth.
    def self.random_coordinates
      latitude = rand(-90.0..90.0)
      longitude = rand(-180.0..180.0)
      [latitude, longitude]
    end
  end
end

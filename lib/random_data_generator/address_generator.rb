# frozen_string_literal: true

module RandomDataGenerator
  module AddressGenerator
    RESOURCES_DIR = File.expand_path('../../resources', __dir__)

    def self.read_words(file_path)
      File.readlines(file_path).flat_map(&:split)
    end

    CITIES = read_words(File.join(RESOURCES_DIR, 'cities.txt')).freeze
    STREET_NAMES = read_words(File.join(RESOURCES_DIR, 'street_names.txt')).freeze

    def self.random_city
      CITIES.sample
    end

    def self.random_house_number
      rand(1..1000)
    end

    def self.random_street_name
      STREET_NAMES.sample
    end

    def self.random_address
      "#{random_house_number} #{random_street_name}, #{random_city}"
    end

    def self.random_coordinates
      [rand(-90.0..90.0), rand(-180.0..180.0)]
    end
  end
end

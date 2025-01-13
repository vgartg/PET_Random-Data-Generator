# frozen_string_literal: true

module RandomDataGenerator
  module OtherGenerator
    # Method to read words from a file
    def self.read_words(file_path)
      File.readlines(file_path).flat_map { |line| line.split }
    end

    # Generates a random text description.
    def self.random_text_description
      descriptions = File.readlines('resources/descriptions.txt').map(&:strip)
      descriptions.sample
    end

    # Generates a random number within the specified range.
    def self.random_number(min, max)
      rand(min..max)
    end

    # Generates a random date within the specified range.
    def self.random_date(start_date, end_date)
      rand(start_date..end_date)
    end

    # Generates a random color.
    def self.random_color
      "##{rand(0..0xFFFFFF).to_s(16).rjust(6, '0')}"
    end
  end
end

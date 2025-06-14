# frozen_string_literal: true

require 'securerandom'

module RandomDataGenerator
  module OtherGenerator
    RESOURCES_DIR = File.expand_path('../../resources', __dir__)

    DESCRIPTIONS = File.readlines(File.join(RESOURCES_DIR, 'descriptions.txt'))
                       .map(&:strip)
                       .reject(&:empty?)
                       .freeze

    def self.random_text_description
      DESCRIPTIONS.sample
    end

    def self.random_number(min, max)
      rand(min..max)
    end

    def self.random_date(start_date, end_date)
      rand(start_date..end_date)
    end

    def self.random_color
      "##{rand(0..0xFFFFFF).to_s(16).rjust(6, '0').upcase}"
    end

    def self.random_boolean
      [true, false].sample
    end

    def self.random_uuid
      SecureRandom.uuid
    end
  end
end

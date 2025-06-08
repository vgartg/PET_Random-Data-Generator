# frozen_string_literal: true

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
      hex = Array.new(16) { rand(256) }
      hex[6] = (hex[6] & 0x0F) | 0x40
      hex[8] = (hex[8] & 0x3F) | 0x80
      hex.map { |b| b.to_s(16).rjust(2, '0') }.join.then do |s|
        "#{s[0..7]}-#{s[8..11]}-#{s[12..15]}-#{s[16..19]}-#{s[20..31]}"
      end
    end
  end
end

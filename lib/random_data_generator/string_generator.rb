# frozen_string_literal: true

module RandomDataGenerator
  module StringGenerator
    LETTERS = (('a'..'z').to_a + ('A'..'Z').to_a).freeze
    DIGITS = ('0'..'9').to_a.freeze
    LOWERCASE = ('a'..'z').to_a.freeze
    ALPHANUMERIC = (LETTERS + DIGITS).freeze

    def self.random_string(length)
      Array.new(length) { LETTERS.sample }.join
    end

    def self.random_alpha_numeric_string(length)
      Array.new(length) { ALPHANUMERIC.sample }.join
    end

    def self.random_letter_string(length)
      Array.new(length) { LOWERCASE.sample }.join
    end
  end
end

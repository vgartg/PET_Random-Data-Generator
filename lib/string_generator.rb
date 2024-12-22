# frozen_string_literal: true

module StringGenerator
  # Generates a random string of specified length.
  def self.random_string(length)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a
    Array.new(length) { chars.sample }.join
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
end

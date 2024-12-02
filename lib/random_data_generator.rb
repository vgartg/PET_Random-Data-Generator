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
    domain = %w[gmail.com yahoo.com outlook.com example.com].sample
    username = random_string(8)
    "#{username}@#{domain}"
  end
end

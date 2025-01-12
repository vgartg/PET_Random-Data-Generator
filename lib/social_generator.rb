# frozen_string_literal: true
#
require_relative '../lib/string_generator'

module RandomDataGenerator
  module SocialGenerator
    # Generates a random email address.
    def self.random_email
      username = StringGenerator.random_string(8)
      domain = %w[gmail yahoo outlook example].sample
      domain_extension = %w[com net org co.uk].sample
      "#{username}@#{domain}.#{domain_extension}"
    end

    # Generates a random IP address.
    def self.random_ip_address
      (1..4).map { rand(256) }.join('.')
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

    # Generates a random company name.
    def self.random_company_name
      company_suffixes = %w[Inc Ltd LLC Corp Ltda SA]
      company_prefixes = %w[ABC XYZ Best First Global Smart]
      "#{company_prefixes.sample} #{company_suffixes.sample}"
    end

    # Generates a random URL.
    def self.random_url
      schemes = %w[http https]
      extensions = %w[com net org edu gov]
      "#{schemes.sample}://www.example#{rand(100..999)}.#{extensions.sample}"
    end
  end
end

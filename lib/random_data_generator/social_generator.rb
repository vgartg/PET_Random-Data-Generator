# frozen_string_literal: true

require_relative 'string_generator'

module RandomDataGenerator
  module SocialGenerator
    EMAIL_DOMAINS = %w[gmail yahoo outlook example].freeze
    EMAIL_TLDS = %w[com net org co.uk].freeze
    FIRST_NAMES = %w[John Jane Michael Sarah James Emily Robert Olivia William Sophia].freeze
    LAST_NAMES = %w[Smith Johnson Williams Jones Brown Davis Miller Wilson Moore Taylor].freeze
    ANIMALS = %w[Dog Cat Rabbit Bird Fish Elephant Tiger Lion Wolf Fox Bear Otter].freeze
    COMPANY_PREFIXES = %w[ABC XYZ Best First Global Smart Bright Quantum Nova Apex].freeze
    COMPANY_SUFFIXES = %w[Inc Ltd LLC Corp Ltda SA GmbH BV].freeze
    URL_SCHEMES = %w[http https].freeze
    URL_TLDS = %w[com net org edu gov io dev].freeze

    def self.random_email
      username = StringGenerator.random_string(8).downcase
      "#{username}@#{EMAIL_DOMAINS.sample}.#{EMAIL_TLDS.sample}"
    end

    def self.random_ip_address
      Array.new(4) { rand(256) }.join('.')
    end

    def self.random_phone_number
      "+1-#{rand(100..999)}-#{rand(100..999)}-#{rand(1000..9999)}"
    end

    def self.random_person_name
      "#{FIRST_NAMES.sample} #{LAST_NAMES.sample}"
    end

    def self.random_animal_name
      "#{ANIMALS.sample}-#{rand(1000..9999)}"
    end

    def self.random_company_name
      "#{COMPANY_PREFIXES.sample} #{COMPANY_SUFFIXES.sample}"
    end

    def self.random_url
      "#{URL_SCHEMES.sample}://www.example#{rand(100..999)}.#{URL_TLDS.sample}"
    end
  end
end

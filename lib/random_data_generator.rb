# frozen_string_literal: true

require_relative 'random_data_generator/version'
require_relative 'random_data_generator/string_generator'
require_relative 'random_data_generator/other_generator'
require_relative 'random_data_generator/social_generator'
require_relative 'random_data_generator/address_generator'

module RandomDataGenerator
  GENERATORS = {
    string: StringGenerator,
    other: OtherGenerator,
    social: SocialGenerator,
    address: AddressGenerator
  }.freeze
end

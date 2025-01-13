# frozen_string_literal: true

# Load necessary modules
require_relative '../lib/random_data_generator/address_generator'
require_relative '../lib/random_data_generator/other_generator'
require_relative '../lib/random_data_generator/social_generator'
require_relative '../lib/random_data_generator/string_generator'
require 'date'

# Demonstrate methods from StringGenerator module
puts "=== StringGenerator ==="
puts "Random String: #{RandomDataGenerator::StringGenerator.random_string(10)}"
puts "Random Alpha-Numeric String: #{RandomDataGenerator::StringGenerator.random_alpha_numeric_string(10)}"
puts "Random Letter String: #{RandomDataGenerator::StringGenerator.random_letter_string(10)}"
puts

# Demonstrate methods from OtherGenerator module
puts "=== OtherGenerator ==="
puts "Random Text Description: #{RandomDataGenerator::OtherGenerator.random_text_description}"
puts "Random Number: #{RandomDataGenerator::OtherGenerator.random_number(1, 100)}"
puts "Random Date: #{RandomDataGenerator::OtherGenerator.random_date(Date.today - 365, Date.today)}"
puts "Random Color: #{RandomDataGenerator::OtherGenerator.random_color}"
puts

# Demonstrate methods from SocialGenerator module
puts "=== SocialGenerator ==="
puts "Random Email: #{RandomDataGenerator::SocialGenerator.random_email}"
puts "Random IP Address: #{RandomDataGenerator::SocialGenerator.random_ip_address}"
puts "Random Phone Number: #{RandomDataGenerator::SocialGenerator.random_phone_number}"
puts "Random Person Name: #{RandomDataGenerator::SocialGenerator.random_person_name}"
puts "Random Animal Name: #{RandomDataGenerator::SocialGenerator.random_animal_name}"
puts "Random Company Name: #{RandomDataGenerator::SocialGenerator.random_company_name}"
puts "Random URL: #{RandomDataGenerator::SocialGenerator.random_url}"
puts
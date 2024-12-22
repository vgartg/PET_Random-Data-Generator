# frozen_string_literal: true

# Load necessary modules
require_relative '../lib/address_generator'
require_relative '../lib/other_generator'
require_relative '../lib/social_generator'
require_relative '../lib/string_generator'
require 'date'

# Demonstrate methods from StringGenerator module
puts "=== StringGenerator ==="
puts "Random String: #{StringGenerator.random_string(10)}"
puts "Random Alpha-Numeric String: #{StringGenerator.random_alpha_numeric_string(10)}"
puts "Random Letter String: #{StringGenerator.random_letter_string(10)}"
puts

# Demonstrate methods from OtherGenerator module
puts "=== OtherGenerator ==="
puts "Random Text Description: #{OtherGenerator.random_text_description}"
puts "Random Number: #{OtherGenerator.random_number(1, 100)}"
puts "Random Date: #{OtherGenerator.random_date(Date.today - 365, Date.today)}"
puts "Random Color: #{OtherGenerator.random_color}"
puts

# Demonstrate methods from SocialGenerator module
puts "=== SocialGenerator ==="
puts "Random Email: #{SocialGenerator.random_email}"
puts "Random IP Address: #{SocialGenerator.random_ip_address}"
puts "Random Phone Number: #{SocialGenerator.random_phone_number}"
puts "Random Person Name: #{SocialGenerator.random_person_name}"
puts "Random Animal Name: #{SocialGenerator.random_animal_name}"
puts "Random Company Name: #{SocialGenerator.random_company_name}"
puts "Random URL: #{SocialGenerator.random_url}"
puts
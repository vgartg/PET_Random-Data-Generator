# frozen_string_literal: true

require_relative '../lib/random_data_generator'
require 'date'

puts "Random string: #{RandomDataGenerator.random_string(10)}"
puts "Random number: #{RandomDataGenerator.random_number(1, 100)}"
puts "Random date: #{RandomDataGenerator.random_date(Date.new(2020, 1, 1), Date.new(2025, 12, 31))}"
puts "Random alpha-numeric string: #{RandomDataGenerator.random_alpha_numeric_string(10)}"
puts "Random letter string: #{RandomDataGenerator.random_letter_string(10)}"
puts "Random IP address: #{RandomDataGenerator.random_ip_address}"
puts "Random email: #{RandomDataGenerator.random_email}"

puts "Random company name: #{RandomDataGenerator.random_company_name}"
puts "Random phone number: #{RandomDataGenerator.random_phone_number}"
puts "Random person name: #{RandomDataGenerator.random_person_name}"
puts "Random animal name: #{RandomDataGenerator.random_animal_name}"
puts "Random text description: #{RandomDataGenerator.random_text_description}"
puts "Random URL: #{RandomDataGenerator.random_url}"
puts "Random color: #{RandomDataGenerator.random_color}"
latitude, longitude = RandomDataGenerator.random_coordinates
puts "Random coordinates: Latitude: #{latitude}, Longitude: #{longitude}"

puts "Random city: #{RandomDataGenerator::RandomDataGenerator.random_city}"
puts "Random house number: #{RandomDataGenerator::RandomDataGenerator.random_house_number}"
puts "Random street name: #{RandomDataGenerator::RandomDataGenerator.random_street_name}"
puts "Random address: #{RandomDataGenerator::RandomDataGenerator.random_address}"

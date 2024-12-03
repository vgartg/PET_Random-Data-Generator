# frozen_string_literal: true

require_relative '../lib/random_data_generator'
require 'date'

# Генерация и вывод случайных данных с использованием методов из модуля RandomDataGenerator

puts "Random string: #{RandomDataGenerator.random_string(10)}"
puts "Random number: #{RandomDataGenerator.random_number(1, 100)}"
puts "Random date: #{RandomDataGenerator.random_date(Date.new(2020, 1, 1), Date.new(2025, 12, 31))}"
puts "Random alpha-numeric string: #{RandomDataGenerator.random_alpha_numeric_string(10)}"
puts "Random letter string: #{RandomDataGenerator.random_letter_string(10)}"
puts "Random IP address: #{RandomDataGenerator.random_ip_address}"
puts "Random email: #{RandomDataGenerator.random_email}"

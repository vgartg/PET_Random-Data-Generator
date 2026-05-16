# frozen_string_literal: true

require 'date'
require 'json'
require 'sinatra/base'
require 'sinatra/json'

lib_path = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'random_data_generator'

module RandomDataGenerator
  class API < Sinatra::Base
    configure do
      set :show_exceptions, false
      set :raise_errors, false
      set :public_folder, File.expand_path('../web/dist', __dir__)
      set :default_content_type, 'application/json'
    end

    before do
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
      response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Accept'
    end

    options '*' do
      200
    end

    error JSON::ParserError do
      status 400
      json error: 'invalid_json', message: env['sinatra.error'].message
    end

    error StandardError do
      status 500
      json error: 'internal_error', message: env['sinatra.error'].message
    end

    helpers do
      def int_param(name, default:, min: nil, max: nil)
        value = params[name]&.to_s
        return default if value.nil? || value.empty?

        parsed = Integer(value, 10)
        raise ArgumentError, "#{name} must be >= #{min}" if min && parsed < min
        raise ArgumentError, "#{name} must be <= #{max}" if max && parsed > max

        parsed
      rescue ArgumentError => e
        halt 400, json(error: 'invalid_param', param: name.to_s, message: e.message)
      end

      def date_param(name, default:)
        value = params[name]&.to_s
        return default if value.nil? || value.empty?

        Date.iso8601(value)
      rescue ArgumentError
        halt 400, json(error: 'invalid_param', param: name.to_s,
                       message: 'expected ISO 8601 date (YYYY-MM-DD)')
      end
    end

    get '/api/health' do
      json status: 'ok', version: RandomDataGenerator::VERSION
    end

    get '/api/generators' do
      json generators: %w[
        string/string
        string/alpha_numeric
        string/letter
        social/email
        social/ip_address
        social/phone_number
        social/person_name
        social/animal_name
        social/company_name
        social/url
        address/city
        address/street_name
        address/house_number
        address/address
        address/coordinates
        other/number
        other/date
        other/color
        other/text_description
        other/boolean
        other/uuid
      ]
    end

    get '/api/string/string' do
      length = int_param(:length, default: 10, min: 1, max: 1024)
      json value: StringGenerator.random_string(length), length: length
    end

    get '/api/string/alpha_numeric' do
      length = int_param(:length, default: 10, min: 1, max: 1024)
      json value: StringGenerator.random_alpha_numeric_string(length), length: length
    end

    get '/api/string/letter' do
      length = int_param(:length, default: 10, min: 1, max: 1024)
      json value: StringGenerator.random_letter_string(length), length: length
    end

    get '/api/social/email' do
      json value: SocialGenerator.random_email
    end

    get '/api/social/ip_address' do
      json value: SocialGenerator.random_ip_address
    end

    get '/api/social/phone_number' do
      json value: SocialGenerator.random_phone_number
    end

    get '/api/social/person_name' do
      json value: SocialGenerator.random_person_name
    end

    get '/api/social/animal_name' do
      json value: SocialGenerator.random_animal_name
    end

    get '/api/social/company_name' do
      json value: SocialGenerator.random_company_name
    end

    get '/api/social/url' do
      json value: SocialGenerator.random_url
    end

    get '/api/address/city' do
      json value: AddressGenerator.random_city
    end

    get '/api/address/street_name' do
      json value: AddressGenerator.random_street_name
    end

    get '/api/address/house_number' do
      json value: AddressGenerator.random_house_number
    end

    get '/api/address/address' do
      json value: AddressGenerator.random_address
    end

    get '/api/address/coordinates' do
      lat, lng = AddressGenerator.random_coordinates
      json value: { latitude: lat, longitude: lng }
    end

    get '/api/other/number' do
      min = int_param(:min, default: 1)
      max = int_param(:max, default: 100)
      halt 400, json(error: 'invalid_range', message: 'min must be <= max') if min > max
      json value: OtherGenerator.random_number(min, max), min: min, max: max
    end

    get '/api/other/date' do
      start_date = date_param(:from, default: Date.new(2000, 1, 1))
      end_date = date_param(:to, default: Date.today)
      halt 400, json(error: 'invalid_range', message: 'from must be <= to') if start_date > end_date
      json value: OtherGenerator.random_date(start_date, end_date).iso8601,
           from: start_date.iso8601,
           to: end_date.iso8601
    end

    get '/api/other/color' do
      json value: OtherGenerator.random_color
    end

    get '/api/other/text_description' do
      json value: OtherGenerator.random_text_description
    end

    get '/api/other/boolean' do
      json value: OtherGenerator.random_boolean
    end

    get '/api/other/uuid' do
      json value: OtherGenerator.random_uuid
    end

    get '/' do
      index = File.join(settings.public_folder.to_s, 'index.html')
      if File.exist?(index)
        send_file index
      else
        content_type :json
        json status: 'ok',
             message: 'API is running. Build the frontend with `npm run build` inside web/ to serve the UI.',
             docs: '/api/generators'
      end
    end

    not_found do
      content_type :json
      json error: 'not_found', path: request.path_info
    end
  end
end

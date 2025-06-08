# frozen_string_literal: true

require 'rack/test'
require 'json'

require_relative '../../api/app'

RSpec.describe RandomDataGenerator::API do
  include Rack::Test::Methods

  def app
    described_class
  end

  def json_body
    JSON.parse(last_response.body)
  end

  describe 'GET /api/health' do
    it 'returns status ok and the library version' do
      get '/api/health'
      expect(last_response.status).to eq(200)
      expect(json_body).to include('status' => 'ok', 'version' => RandomDataGenerator::VERSION)
    end
  end

  describe 'GET /api/generators' do
    it 'lists every registered generator endpoint' do
      get '/api/generators'
      expect(last_response.status).to eq(200)
      expect(json_body['generators']).to include('string/string', 'social/email', 'other/uuid')
    end
  end

  describe 'GET /api/string/string' do
    it 'uses the default length when none is given' do
      get '/api/string/string'
      expect(last_response.status).to eq(200)
      expect(json_body['value'].length).to eq(10)
    end

    it 'honors the length parameter' do
      get '/api/string/string', length: 42
      expect(json_body['value'].length).to eq(42)
      expect(json_body['length']).to eq(42)
    end

    it 'rejects non-numeric length' do
      get '/api/string/string', length: 'oops'
      expect(last_response.status).to eq(400)
      expect(json_body['error']).to eq('invalid_param')
    end

    it 'rejects lengths above the cap' do
      get '/api/string/string', length: 99_999
      expect(last_response.status).to eq(400)
    end
  end

  describe 'GET /api/other/number' do
    it 'returns a number inside the inclusive range' do
      get '/api/other/number', min: 50, max: 60
      expect(last_response.status).to eq(200)
      expect(json_body['value']).to be_between(50, 60).inclusive
    end

    it 'rejects an inverted range' do
      get '/api/other/number', min: 10, max: 1
      expect(last_response.status).to eq(400)
      expect(json_body['error']).to eq('invalid_range')
    end
  end

  describe 'GET /api/other/date' do
    it 'returns an ISO date inside the inclusive range' do
      get '/api/other/date', from: '2024-01-01', to: '2024-12-31'
      expect(last_response.status).to eq(200)
      date = Date.iso8601(json_body['value'])
      expect(date).to be_between(Date.new(2024, 1, 1), Date.new(2024, 12, 31)).inclusive
    end

    it 'rejects non-ISO dates' do
      get '/api/other/date', from: '2024/01/01'
      expect(last_response.status).to eq(400)
    end
  end

  describe 'GET /api/address/coordinates' do
    it 'returns latitude and longitude' do
      get '/api/address/coordinates'
      expect(last_response.status).to eq(200)
      value = json_body['value']
      expect(value['latitude']).to be_between(-90.0, 90.0).inclusive
      expect(value['longitude']).to be_between(-180.0, 180.0).inclusive
    end
  end

  describe 'GET an unknown endpoint' do
    it 'returns a JSON 404' do
      get '/api/does-not-exist'
      expect(last_response.status).to eq(404)
      expect(json_body['error']).to eq('not_found')
    end
  end

  describe 'OPTIONS /api/health' do
    it 'responds with permissive CORS headers' do
      options '/api/health'
      expect(last_response.status).to eq(200)
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq('*')
    end
  end
end

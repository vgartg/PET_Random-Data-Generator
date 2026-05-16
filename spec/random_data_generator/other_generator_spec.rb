# frozen_string_literal: true

RSpec.describe RandomDataGenerator::OtherGenerator do
  describe '.random_text_description' do
    it 'returns a non-empty string' do
      description = described_class.random_text_description
      expect(description).to be_a(String).and(satisfy { |s| !s.empty? })
    end
  end

  describe '.random_number' do
    it 'returns an integer inside the inclusive range' do
      number = described_class.random_number(1, 100)
      expect(number).to be_between(1, 100).inclusive
    end
  end

  describe '.random_date' do
    it 'returns a date inside the inclusive range' do
      start_date = Date.new(2020, 1, 1)
      end_date = Date.new(2025, 12, 31)
      date = described_class.random_date(start_date, end_date)
      expect(date).to be_between(start_date, end_date).inclusive
    end
  end

  describe '.random_color' do
    it 'returns an uppercase 6-digit hex color' do
      expect(described_class.random_color).to match(/^#[0-9A-F]{6}$/)
    end
  end

  describe '.random_boolean' do
    it 'returns true or false' do
      expect(described_class.random_boolean).to be(true).or be(false)
    end
  end

  describe '.random_uuid' do
    it 'returns a valid v4 UUID' do
      expect(described_class.random_uuid)
        .to match(/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/)
    end
  end
end

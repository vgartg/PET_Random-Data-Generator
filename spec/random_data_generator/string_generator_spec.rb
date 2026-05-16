# frozen_string_literal: true

RSpec.describe RandomDataGenerator::StringGenerator do
  describe '.random_string' do
    it 'returns mixed-case letters of the requested length' do
      expect(described_class.random_string(10)).to match(/^[a-zA-Z]{10}$/)
    end
  end

  describe '.random_alpha_numeric_string' do
    it 'returns letters and digits of the requested length' do
      expect(described_class.random_alpha_numeric_string(10)).to match(/^[a-zA-Z0-9]{10}$/)
    end
  end

  describe '.random_letter_string' do
    it 'returns lowercase ASCII letters of the requested length' do
      expect(described_class.random_letter_string(10)).to match(/^[a-z]{10}$/)
    end
  end
end

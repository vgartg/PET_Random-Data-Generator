# frozen_string_literal: true

RSpec.describe RandomDataGenerator::SocialGenerator do
  describe '.random_email' do
    it 'returns an email matching the documented shape' do
      expect(described_class.random_email).to match(/^[a-z]{8}@[a-z]+\.(com|net|org|co\.uk)$/)
    end
  end

  describe '.random_ip_address' do
    it 'returns four octets in dotted form' do
      ip = described_class.random_ip_address
      expect(ip).to match(/^\d{1,3}(\.\d{1,3}){3}$/)
      ip.split('.').each { |octet| expect(octet.to_i).to be_between(0, 255).inclusive }
    end
  end

  describe '.random_phone_number' do
    it 'returns a phone in +1-NXX-NXX-NNNN form' do
      expect(described_class.random_phone_number).to match(/^\+1-\d{3}-\d{3}-\d{4}$/)
    end
  end

  describe '.random_person_name' do
    it 'returns "<First> <Last>"' do
      expect(described_class.random_person_name).to match(/^[A-Z][a-z]+ [A-Z][a-z]+$/)
    end
  end

  describe '.random_animal_name' do
    it 'returns "<Animal>-<NNNN>"' do
      expect(described_class.random_animal_name).to match(/^[A-Z][a-z]+-\d{4}$/)
    end
  end

  describe '.random_company_name' do
    it 'returns "<Prefix> <Suffix>"' do
      expect(described_class.random_company_name).to match(/^[A-Za-z]+ [A-Za-z]+$/)
    end
  end

  describe '.random_url' do
    it 'returns a valid http/https URL' do
      expect(described_class.random_url).to match(%r{^https?://www\.example\d{3}\.[a-z]+$})
    end
  end
end

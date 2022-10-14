require 'rails_helper'

RSpec.describe(User, type: :model) do
  after { described_class.delete_all }

  describe('with valid arguments') do
    subject do
      described_class.new(name: 'TEST_USER', email: 'test@dev.email', password: 'test@123')
    end

    it { should be_valid }
  end

  describe('Associations') do
    it { should have_many(:entities) }

    it { should have_many(:categories) }
  end

  describe('with invalid arguments') do
    it('should be invalid') do
      expect(described_class.new).to_not be_valid
    end

    it('should fail with less than 3 chars') do
      user = described_class.new(name: 'HI', email: 'test@dev.email', password: 'test@123')
      expect(user).to_not be_valid
    end

    it('should fail without email') do
      user = described_class.new(name: 'TEST_USER', password: 'test@123')
      expect(user).to_not be_valid
    end

    it('should fail without password') do
      user = described_class.new(name: 'TEST_USER', email: 'test@dev.email')
      expect(user).to_not be_valid
    end
  end
end

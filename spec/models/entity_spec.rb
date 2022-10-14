require 'rails_helper'

RSpec.describe(Entity, type: :model) do
  before(:all) { @author = User.new(name: 'USER', email: 'test@dev.email', password: 'PWD@123') }

  describe('Associations') do
    it { should belong_to(:author) }

    it { should have_many(:categorizations) }

    it { should have_many(:categories).through(:categorizations) }
  end

  describe('with valid arguments') do
    it('should be valid') do
      entity = described_class.new(name: 'user', amount: 8.5, author: @author)
      expect(entity).to be_valid
    end
  end

  describe('with invalid arguments') do
    it('without arguments') { expect(described_class.new).to_not be_valid }

    it('without name') do
      entity = described_class.new(amount: 8.5, author: @author)
      expect(entity).to_not be_valid
    end

    it('with short name') do
      entity = described_class.new(name: 'en', amount: 8.5, author: @author)
      expect(entity).to_not be_valid
    end

    it('without amount') do
      entity = described_class.new(name: 'eng', author: @author)
      expect(entity).to_not be_valid
    end

    it('with wrong amount') do
      entity = described_class.new(name: 'eng', amount: '-8.5', author: @author)
      expect(entity).to_not be_valid
    end
  end
end

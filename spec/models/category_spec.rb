require 'rails_helper'

RSpec.describe(Category, type: :model) do
  let(:author) { User.new(name: 'USER', email: 'test@dev.email', password: 'PWD@123') }

  describe('associations') do
    it { should belong_to(:author) }
    it { should have_many(:entities).through(:categorizations) }
    it { should have_many(:categorizations) }
  end

  describe('with valid arguments') do
    it { expect(described_class.new(name: 'CATEG', author:)).to be_valid }
  end

  describe('with invalid arguments') do
    it { expect(described_class.new(author:)).to_not be_valid }
  end
end

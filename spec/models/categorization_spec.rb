require 'rails_helper'

RSpec.describe(Categorization, type: :model) do
  describe('associations') do
    it { should belong_to(:category) }
    it { should belong_to(:entity) }
  end
end

require 'rails_helper'

RSpec.describe('Entities', type: :request) do
  describe('GET /index') do
    before { get category_entities_path(1) }

    it('redirects without session') do
      expect(response).to have_http_status(:found)
    end
  end
end

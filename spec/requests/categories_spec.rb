require 'rails_helper'

RSpec.describe('Categories', type: :request) do
  describe('GET /index') do
    before { get root_path }

    it('should have a redirect status :found') do
      expect(response).to have_http_status(:found)
    end
  end
end

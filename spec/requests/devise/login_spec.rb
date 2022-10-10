require 'rails_helper'

RSpec.describe('Login Page', type: :request) do
  describe('renders successfully') do
    before { get new_user_session_path }

    it('should have a success status') do
      expect(response).to have_http_status(:ok)
    end
  end
end

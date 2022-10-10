require 'rails_helper'

RSpec.describe('Splash Screen', type: :request) do
  describe('renders successfully') do
    before { get root_path }

    it('should have a success status') do
      expect(response).to have_http_status(:ok)
    end

    it('should render a home/splash view') do
      expect(response).to render_template(:splash)
    end
  end
end

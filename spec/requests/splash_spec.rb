require 'rails_helper'

RSpec.describe('Splash Screen', type: :request) do
  describe('renders successfully') do
    before { get get_started_path }

    it('should have a success status') do
      expect(response).to have_http_status(:ok)
    end

    it('should render a splash/index view') do
      expect(response).to render_template(:index)
    end
  end
end

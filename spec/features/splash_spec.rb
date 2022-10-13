require 'rails_helper'

RSpec.describe('Splash', type: :feature) do
  describe('without user session') do
    before { visit(get_started_path) }

    it('displays the app title') do
      expect(page).to have_content(ENV.fetch('APP_TITLE'))
    end

    it('contains 2 link') do
      expect(page).to have_css('a', count: 2)
    end

    it('contains link to signin page') do
      expect(page).to have_css("[href='#{new_user_session_path}']")
    end

    it('contains link to signup page') do
      expect(page).to have_css("[href='#{new_user_registration_path}']")
    end
  end

  describe('with user session') do
    after { User.destroy_all }

    it('redirects to categories page') do
      auto_sign_out(create_user(email: 'test@email')) do
        visit(get_started_path)
        expect(current_path).to eq(root_path)
      end
    end
  end
end

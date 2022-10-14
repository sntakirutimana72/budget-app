require 'rails_helper'

RSpec.describe('Categories', type: :feature) do
  describe('without user session') do
    it('redirects to :get_started_path') do
      visit(root_path)
      expect(current_path).to eq(get_started_path)
    end
  end

  describe('with user session') do
    before do
      @user = create_user(email: 'test@email')
      sign_in(@user)
      visit(root_path)
    end
    after do
      sign_out(@user)
      Category.delete_all
      User.delete_all
    end

    it('display `No records found` without categories') do
      expect(page).to have_content('No records found')
    end

    context('with categories') do
      before do
        @categ1 = create_category(author: @user)
        @categ2 = create_category(author: @user, name: 'other category')
        page.refresh
      end

      it('displays all available categories') do
        expect(page).to have_content(@categ1.name)
        expect(page).to have_content(@categ2.name)
      end

      it('contains links to transactions pages') do
        expect(page).to have_css("[href='#{category_entities_path(@categ1)}']", count: 1)
        expect(page).to have_css("[href='#{category_entities_path(@categ2)}']", count: 1)
      end
    end

    context('redirects') do
      it('contains a link to new category page') do
        expect(page).to have_css("[href='#{new_category_path}']", count: 1)
      end

      it('can go to new category page') do
        page.click_link('New Category')
        expect(current_path).to eq(new_category_path)
      end

      it('can go to :entities_path') do
        categ = create_category(author: @user, name: 'test_categ_link_with_name')
        page.refresh
        page.click_link(categ.name)
        expect(current_path).to eq(category_entities_path(categ))
      end
    end

    context('new category page') do
      before { page.click_link('New Category') }

      it('contains fields') { expect(page).to have_css('[type=text]', count: 2) }
      it('contains :submit button') { expect(page).to have_button('Create') }
      it('contains a :back button') { expect(page).to have_link('') }

      it('when you click on the :back, it leads to :root_path') do
        page.click_link('')
        expect(current_path).to eq(root_path)
      end

      it('when you click on :submit button, it creates a new category') do
        exp_counter = Category.where(author: @user).count + 1

        fill_in(:category_name, with: 'cat_form_test')
        fill_in(:category_icon, with: '')

        page.click_button('Create')

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Category created successfully!')
        expect(page).to have_content('cat_form_test')
        expect(exp_counter).to eq(Category.where(author: @user).count)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe('Entities', type: :feature) do
  describe('without user session') do
    it('should redirect to root_path') do
      visit(categories_path)
      expect(current_path).to eq(root_path)
    end
  end

  describe('with user session') do
    before do
      @user = create_user(email: 'test@email')
      @categ = create_category(author: @user)
      sign_in(@user)
      visit(category_entities_path(@categ))
    end

    after do
      sign_out(@user)
      Categorization.delete_all
      Entity.delete_all
      Category.delete_all
      User.delete_all
    end

    it('display `No records found` without categories') do
      expect(page).to have_content('No records found')
    end

    it('displays all available transactions') do
      trans1 = create_trans(author: @user, categs: [@categ])
      trans2 = create_trans(author: @user, categs: [@categ], name: 'another_trans_test_name')

      page.refresh

      expect(page).to have_css('h3', text: trans1.name)
      expect(page).to have_css('h3', text: trans2.name)
    end

    it('contains a link to new transaction page') { expect(page).to have_link('New Transaction') }

    it('when you click on New Transtion link, it leads to new_category_entity_path') do
      page.click_link('New Transaction')
      expect(current_path).to eq(new_category_entity_path(@categ))
    end

    it('contains a :back button') { expect(page).to have_link('<') }

    it('when you click on the :back, it leads to :categories_path') do
      page.click_link('<')
      expect(current_path).to eq(categories_path)
    end

    context('new transaction page') do
      before { page.click_link('New Transaction') }

      it('contains fields') do
        expect(page).to have_css('[type=text]', count: 1)
        expect(page).to have_css('[type=number]', count: 1)
      end

      it('has a :Create button') { expect(page).to have_button('Create') }

      it('when you click on :Create button, a new transaction is created') do
        exp_counter = @categ.entities.count + 1

        fill_in(:entity_name, with: 'new_transaction_spec_form')
        fill_in(:entity_amount, with: '2.42')

        page.click_button('Create')

        expect(current_path).to eq(category_entities_path(@categ))
        expect(page).to have_content('Transaction created successfully!')
        expect(page).to have_css('h3', text: 'new_transaction_spec_form')
        expect(exp_counter).to eq(@categ.entities.count)
      end
    end
  end
end

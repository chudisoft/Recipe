require 'rails_helper'

RSpec.describe 'Recipe index', type: :feature do
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  let(:user) { User.new(name: 'example', email: 'user@example.com', password: 'password') }
  let(:food) { Food.new(name: 'Flour', measurement_unit: 'grams', price: 2, quantity: 10, user:) }
  let(:recipe) do
    Recipe.new(name: 'Bread', preparation_time: 20, cooking_time: 30, description: 'This is how to prepare the recipe',
               public: false, user:)
  end

  before { user.save }
  before { food.save }
  before { recipe.save }

  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit recipes_path
  end

  describe 'recipe index' do
    it 'shows a list of recipes' do
      expect(page).to have_content('Your Recipes')
      user.recipes.each do |recipe|
        expect(page).to have_content(recipe.name)
      end
    end
  end

  describe 'Click events' do
    it 'navigates to the details page' do
      click_on recipe.name
      expect(page).to have_current_path(recipe_path(recipe))
      expect(page).to have_content(recipe.name)
    end
  end
end

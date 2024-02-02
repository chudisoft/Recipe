require 'rails_helper'

RSpec.describe 'Recipe', type: :model do
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

  context 'validity' do
    it 'is valid when all attributes are present' do
      expect(recipe).to be_valid
    end
  end

  context 'invalidity:' do
    it 'is not valid when name is not present' do
      recipe.name = nil
      expect(recipe).not_to be_valid
    end

    it 'is not valid when cooking_time is less than or equal to zero' do
      recipe.cooking_time = 0
      expect(recipe).not_to be_valid
    end
    it 'is not valid when preparation_time is less than or equal to zero' do
      recipe.preparation_time = 0
      expect(recipe).not_to be_valid
    end

    it 'is not valid when descripion length is less than 10' do
      recipe.description = 'a' * 5
      expect(recipe).not_to be_valid
    end
  end
end

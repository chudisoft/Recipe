require 'rails_helper'

RSpec.describe 'Food', type: :model do
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'

  let(:user) { User.new(name: 'example', email: 'user@example.com', password: 'password') }
  let(:food) { Food.new(name: 'Flour', measurement_unit: 'grams', price: 2, quantity: 10, user:) }

  before { user.save }
  before { food.save }

  context 'validity' do
    it 'is valid when all attributes are present' do
      expect(food).to be_valid
    end
  end

  context 'invalidity' do
    it 'is not valid when name is not present' do
      food.name = nil
      expect(food).not_to be_valid
    end

    it 'is not valid when quantity is less than or equal to zero' do
      food.quantity = 0
      expect(food).not_to be_valid
    end
  end
end

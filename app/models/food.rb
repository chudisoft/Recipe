class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1 }
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :quantity, presence: true, numericality: { only_integer: true }, comparison: { greater_than: 0 }

  def food_remnant
    quantity - recipe_foods.sum(:quantity)
  end
end

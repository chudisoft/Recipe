class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1 }
  validates :preparation_time, presence: true, numericality: { only_integer: true }, comparison: { greater_than: 0 }
  validates :cooking_time, presence: true, numericality: { only_integer: true }, comparison: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }
end

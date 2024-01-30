module ApplicationHelper
  def count_public_recipe_food_item(recipe)
    recipe.recipe_foods.count
  end

  def public_recipe_food_item_price(recipe)
    recipe.recipe_foods.reduce(0) do |sum, item|
      sum + (item.quantity * item.food.price)
    end
  end

  def shopping_value(food)
    food.food_remnant.abs * food.price
  end
end

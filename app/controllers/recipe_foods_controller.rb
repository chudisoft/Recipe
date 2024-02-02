class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
    # @foods = current_user.foods.includes(:recipe_foods).where.not(recipe_foods: { recipe: @recipe })

    @foods = current_user.foods.select do |food|
      recipe_foods = food.recipe_foods.select { |recipe_food| recipe_food.recipe == @recipe }
      recipe_foods.empty?
    end
  end

  def create
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = @recipe.id
    @recipe_food.user_id = current_user.id

    if @recipe_food.save
      redirect_to @recipe
    else
      @foods = Food.all
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_food = RecipeFood.includes(:recipe).find_by(id: params[:id])
    if @recipe_food
      @recipe_food.destroy
      redirect_to recipe_path(@recipe), notice: 'Food recipe item was successfully removed.'
    else
      redirect_to recipe_path(@recipe), alert: 'Could not find the food recipe item to remove.'
    end
  end

  def general_shopping_list
    @foods = current_user.foods.all.select { |food| food.food_remnant.negative? }
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end

class RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path
    else
      flash[:alert] = 'recipe could not be deleted.'
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user
      @recipe.update(public: !@recipe.public)
      redirect_to @recipe, notice: 'Recipe visibility toggled.'
    else
      redirect_to @recipe, alert: 'You are not authorized to perform this action.'
    end
  end

  def public_recipes
    @recipes = Recipe.where(public: true)
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :user_id)
  end
end

class FoodsController < ApplicationController
  before_action :set_food, only: %i[destroy]

  # GET /foods or /foods.json
  def index
    @foods = Food.where(user_id: current_user.id)
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user

    if @food.save
      redirect_to foods_path
    else
      render 'new'
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      redirect_to foods_path
    else
      flash[:alert] = 'food could not be deleted.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end

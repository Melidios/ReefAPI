class IngredientsController < ApplicationController
  before_action :set_item
  before_action :set_ingredient, only: [:show, :update, :destroy]

  def index
    @ingredients = @item.ingredients.page(params[:page]).per(10)
    render json: @ingredients, status: :ok
  end

  def show
    if @ingredient
      render json: @ingredient, status: :ok
    else
      render json: { error: 'Ingredient not found' }, status: :not_found
    end
  end

  def create
    @ingredient = @item.ingredients.new(ingredient_params)
    if @ingredient.save
      render json: @ingredient, status: :created
    else
      render json: { errors: @ingredient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      render json: @ingredient, status: :ok
    else
      render json: { errors: @ingredient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient.destroy
    head :no_content
  end

  private

  def set_item
    @item = Item.find_by(id: params[:item_id])
    render json: { error: 'Item not found' }, status: :not_found unless @item
  end

  def set_ingredient
    @ingredient = @item.ingredients.find_by(id: params[:id])
    render json: { error: 'Ingredient not found' }, status: :not_found unless @ingredient
  end

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end

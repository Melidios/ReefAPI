class ItemsController < ApplicationController
  before_action :set_store
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @items = @store.items
    render json: @items, status: :ok
  end

  def show
    if @item
      render json: @item, status: :ok
    else
      render json: { error: 'Item not found' }, status: :not_found
    end
  end

  def create
    @item = @store.items.new(item_params)
    if @item.save
      render json: @item, status: :created
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      render json: @item, status: :ok
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def set_store
    @store = Store.find_by(id: params[:store_id])
    render json: { error: 'Store not found' }, status: :not_found unless @store
  end

  def set_item
    @item = @store.items.find_by(id: params[:id])
    render json: { error: 'Item not found' }, status: :not_found unless @item
  end

  def item_params
    params.require(:item).permit(:name, :price)
  end
end

class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    items = Item.all

    if params[:name]
      items = items.search_by_name(params[:name])
    end

    if params[:store_id]
      items = items.filter_by_store(params[:store_id])
    end

    @items = items.page(params[:page]).per(10)
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
    @item = Item.new(item_params)
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

  def set_item
    @item = Item.find_by(id: params[:id])
    render json: { error: 'Item not found' }, status: :not_found unless @item
  end

  def item_params
    params.require(:item).permit(:name, :price, :store_id)
  end
end

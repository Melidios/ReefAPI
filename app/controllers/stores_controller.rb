class StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]

  def index
    @stores = Store.all
    render json: @stores, status: :ok
  end

  def show
    if @store
      render json: @store, status: :ok
    else
      render json: { error: 'Store not found' }, status: :not_found
    end
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      render json: @store, status: :created
    else
      render json: { errors: @store.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @store.update(store_params)
      render json: @store, status: :ok
    else
      render json: { errors: @store.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @store.destroy
    head :no_content
  end

  private

  def set_store
    @store = Store.find_by(id: params[:id])
    render json: { error: 'Store not found' }, status: :not_found unless @store
  end

  def store_params
    params.require(:store).permit(:name, :address)
  end
end

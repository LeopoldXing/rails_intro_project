class ItemsController < ApplicationController
  def index
    @items = Item.order(:name).page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
  end
end

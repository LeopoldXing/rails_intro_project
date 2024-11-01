class ItemsController < ApplicationController
  def index
    @items = Item.order(:name).page(params[:page]).per(10)
    @total = Item.count
  end

  def show
    @item = Item.find(params[:id])
  end
end

class MovesController < ApplicationController
  def index
    @moves = Move.order(:name).page(params[:page]).per(10)
  end

  def show
    @move = Move.find(params[:id])
  end
end

class AbilitiesController < ApplicationController
  def index
    @abilities = Ability.order(:name).page(params[:page]).per(10)
  end

  def show
    @ability = Ability.find(params[:id])
  end
end

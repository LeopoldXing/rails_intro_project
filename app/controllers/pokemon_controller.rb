class PokemonController < ApplicationController
  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def index
    if params[:keyword].present?
      @pokemons = Pokemon.where("name ILIKE ?", "%#{params[:keyword]}%")
    else
      @pokemons = Pokemon.all
    end
  end
end

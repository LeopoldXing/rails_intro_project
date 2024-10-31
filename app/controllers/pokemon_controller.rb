class PokemonController < ApplicationController
  def show
    @pokemon = Pokemon.find(params[:id])
  end
end

class HomeController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end
end

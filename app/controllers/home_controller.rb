class HomeController < ApplicationController
  def index
    @abilities = Ability.order(:name)
    @items = Item.order(:name)
    @moves = Move.order(:name)

    @pokemons = Pokemon.all

    keyword = params[:keyword].to_s.strip
    if keyword.present?
      @pokemons = @pokemons.where('name ILIKE ?', "%#{keyword}%")
    end

    if params[:ability_id].present?
      @pokemons = @pokemons.joins(:abilities).where(abilities: { id: params[:ability_id] })
    end

    if params[:item_id].present?
      @pokemons = @pokemons.joins(:items).where(items: { id: params[:item_id] })
    end

    if params[:move_id].present?
      @pokemons = @pokemons.joins(:moves).where(moves: { id: params[:move_id] })
    end

    @pokemons = @pokemons.distinct.order(:id)
  end
end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'poke-api-v2'

# Fetch a list of Pokémon
pokemons = PokeApi.get(pokemon: { limit: 100 })

# Initialize arrays to store unique abilities, moves, and items
all_abilities = []
all_moves = []
all_items = []
pokemons_data = []

# Collect abilities, moves, and items for each Pokémon, along with Pokémon data
pokemons.results.each do |pokemon|
  # Fetch detailed information for each Pokémon
  pokemon_details = PokeApi.get(pokemon: pokemon.name)

  # Pokémon data structure for storage
  pokemon_data = {
    id: pokemon_details.id,
    name: pokemon_details.name,
    base_experience: pokemon_details.base_experience,
    height: pokemon_details.height,
    weight: pokemon_details.weight,
    is_default: pokemon_details.is_default,
    order_num: pokemon_details.order,
    type1: pokemon_details.types[0].type.name,
    type2: pokemon_details.types[1]&.type&.name
  }

  # Collect abilities ------------------------------------------------------
  ability_ids = pokemon_details.abilities.map do |ability|
    ability_name = ability.ability.name

    # Check if ability already exists in the database
    existing_ability = Ability.find_or_create_by(name: ability_name)
    all_abilities << ability_name unless all_abilities.include?(ability_name)
    existing_ability.id
  end

  # Collect moves ------------------------------------------------------
  move_ids = pokemon_details.moves.map do |move|
    move_name = move.move.name

    # Check if move already exists in the database
    existing_move = Move.find_or_create_by(name: move_name) do |new_move|
      # Only fetch move details if move is not in the database
      move_details = PokeApi.get(move: move_name)
      new_move.pp = move_details.pp
      new_move.priority = move_details.priority
      new_move.move_type = move_details.type.name
    end
    all_moves << move_name unless all_moves.include?(move_name)
    existing_move.id
  end

  # Collect items ------------------------------------------------------
  item_ids = pokemon_details.held_items.map do |item|
    item_name = item.item.name

    # Check if item already exists in the database
    existing_item = Item.find_or_create_by(name: item_name) do |new_item|
      # fetch item details
      item_details = PokeApi.get(item: item_name)
      new_item.cost = item_details.cost
      new_item.fling_power = item_details.fling_power
    end
    all_items << item_name unless all_items.include?(item_name)
    existing_item.id
  end

  # Collect Pokémon data ------------------------------------------------------
  pokemons_data << { pokemon_data: pokemon_data, ability_ids: ability_ids, move_ids: move_ids, item_ids: item_ids }
end

# Save Pokémon
pokemons_data.each do |data|
  pokemon = Pokemon.find_or_create_by(data[:pokemon_data])

  # Establish relationships with abilities, moves, and items
  data[:ability_ids].each { |ability_id| PokemonAbility.find_or_create_by(pokemon_id: pokemon.id, ability_id: ability_id) }
  data[:move_ids].each { |move_id| PokemonMove.find_or_create_by(pokemon_id: pokemon.id, move_id: move_id) }
  data[:item_ids].each { |item_id| PokemonItem.find_or_create_by(pokemon_id: pokemon.id, item_id: item_id) }
end

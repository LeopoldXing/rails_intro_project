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
pokemons = PokeApi.get(pokemon: { limit: 5 })

all_abilities = []
all_moves = []

# collect both abilities and moves for each Pokémon
pokemons.results.each do |pokemon|
  # Fetch detailed information for each Pokémon
  pokemon_details = PokeApi.get(pokemon: pokemon.name)

  # Collect abilities ------------------------------------------------------
  pokemon_details.abilities.each do |ability|
    ability_name = ability.ability.name
    all_abilities << ability_name unless all_abilities.include?(ability_name)
  end

  # Collect moves ------------------------------------------------------
  pokemon_details.moves.each do |move|
    move_name = move.move.name

    # Check if move is already added
    unless all_moves.any? { |m| m[:name] == move_name }
      # Fetch move details
      move_details = PokeApi.get(move: move_name)

      # Structure the move data
      move_data = {
        name: move_name,
        pp: move_details.pp,
        priority: move_details.priority,
        move_type: move_details.type.name
      }

      # Add move data to the array
      all_moves << move_data
    end
  end
end

# Save abilities to the database
all_abilities.each do |ability_name|
  Ability.find_or_create_by(name: ability_name)
end

# Save moves to the database
all_moves.each do |move_data|
  Move.find_or_create_by(
    name: move_data[:name],
    pp: move_data[:pp],
    priority: move_data[:priority],
    move_type: move_data[:move_type]
  )
end

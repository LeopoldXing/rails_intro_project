class CreatePokemonMoves < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemon_moves do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :move, null: false, foreign_key: true
      t.integer :level_learned_at
      t.string :move_learn_method

      t.timestamps
    end
  end
end

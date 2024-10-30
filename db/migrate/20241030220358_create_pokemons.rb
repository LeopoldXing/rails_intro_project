class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons, id: false do |t|
      t.integer :id, primary_key: true
      t.string :name, null: false
      t.integer :base_experience
      t.integer :height
      t.integer :weight
      t.boolean :is_default
      t.integer :order_num
      t.string :type1
      t.string :type2

      t.timestamps
    end
  end
end

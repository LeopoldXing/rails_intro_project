class CreateMoves < ActiveRecord::Migration[6.1]
  def change
    create_table :moves do |t|
      t.string :name, null: false
      t.integer :pp
      t.integer :priority
      t.string :move_type

      t.timestamps
    end
  end
end

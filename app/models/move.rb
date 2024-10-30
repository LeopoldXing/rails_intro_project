class Move < ApplicationRecord
  has_many :pokemon_moves
  has_many :pokemons, through: :pokemon_moves

  validates :name, presence: true, uniqueness: true
  validates :pp, numericality: { only_integer: true, greater_than: 0 }
end

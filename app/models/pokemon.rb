class Pokemon < ApplicationRecord
  has_many :pokemon_abilities
  has_many :abilities, through: :pokemon_abilities

  has_many :pokemon_moves
  has_many :moves, through: :pokemon_moves

  has_many :pokemon_items
  has_many :items, through: :pokemon_items

  validates :name, presence: true, uniqueness: true
end

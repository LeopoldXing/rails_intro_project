class Item < ApplicationRecord
  has_many :pokemon_items
  has_many :pokemons, through: :pokemon_items

  validates :name, presence: true, uniqueness: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }
end

class Item < ApplicationRecord
  has_many :pokemon_items
  has_many :pokemons, through: :pokemon_items

  validates :name, presence: true, uniqueness: true
end

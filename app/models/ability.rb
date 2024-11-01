class Ability < ApplicationRecord
  has_many :pokemon_abilities
  has_many :pokemons, through: :pokemon_abilities

  validates :name, presence: true, uniqueness: true
  validates :name, length: { maximum: 50 }
end

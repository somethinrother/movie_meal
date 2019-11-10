# frozen_string_literal: true

require 'assets/cocktail_information'

module Utility
  class CocktailParser
    INGREDIENT_KEYS = %i[strIngredient1 strIngredient2 strIngredient3 strIngredient4 strIngredient5 strIngredient6 strIngredient7 strIngredient8 strIngredient9 strIngredient10 strIngredient11 strIngredient12 strIngredient13 strIngredient14 strIngredient15].freeze

    def save_cocktails
      DRINKS.each do |drink|
        cocktail = Cocktail.find_or_create_by(name: drink[:strDrink])
        ingredients = INGREDIENT_KEYS.map { |key| drink[key] }.reject(&:nil?)
        ingredients.each do |ingredient|
          new_ingredient = Ingredient.find_or_create_by(name: ingredient)
          cocktail.ingredients << new_ingredient unless cocktail.ingredients.include?(new_ingredient)
        end
      end
    end

    def find_cocktail_by(*ingredient_search)
      ingredients = ingredient_search.split(' ')
      ingredients.each_with_object([]) do |ingredient_name, ingredients_for_cocktail|
        ingredient = Ingredient.find_by(name: ingredient_name)
        ingredients_for_cocktail << ingredient.cocktails if ingredient
      end.uniq
    end

    def show_ingredients_of(cocktail)
      found_cocktail = find_cocktail(cocktail)
      found_cocktail.ingredients
    end

    def find_cocktail(name)
      Cocktail.find_by(name: name)
    end
  end
end

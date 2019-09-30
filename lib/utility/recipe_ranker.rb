require 'utility/script_scanner'
require 'utility/imsdb_parser'

module Utility
  class RecipeRanker
    attr_accessor :recipes, :movie

    def initialize(movie)
      @movie = movie
      @recipes = nil
    end

    # too intensive to do all at once
    def associate_all_recipes
      find_movie_recipes_associations

      @recipes.each do |recipe|
        @movie.recipes << recipe
      end
    end

    # seeding
    def find_movie_recipes_associations
      all_recipes = Recipe.all
      movie_ingredients = @movie.ingredients

      @recipes = movie_ingredients.each_with_object([]) do |ingredient, recipes|
        ingredient_name = ingredient.name
        
        recipes << all_recipes.select do |recipe|
          recipe_ingredients = recipe.ingredients.map { |ingredient| ingredient.name }
    
          recipe_ingredients.include?(ingredient_name)
        end
      end.flatten.uniq
      create_movie_recipes_associations
    end

    def create_movie_recipes_associations
      @recipes.each do |recipe|
        @movie.recipes << recipe if !@movie.recipes.find_by(id: recipe.id)
      end
    end

    # generates recipe list ranked by ingredient mentions
    def sort_recipes_by_ingredient_mentions
      find_movie_recipes_associations if @movie.recipes.length === 0

      movie_ingredients = @movie.ingredients
      movie_recipes = @movie.recipes
      all_recipes_to_be_sorted = []

      movie_recipes.each do |recipe|
        create_recipe_object_with_ing_mentions(recipe, movie_ingredients, all_recipes_to_be_sorted)
      end
      vet_and_sort_recipes(all_recipes_to_be_sorted)
    end
    
    def create_recipe_object_with_ing_mentions(recipe, movie_ingredients, all_recipes_to_be_sorted)
      found_ingredients = []
      recipe.ingredients.each do |ingredient|
        found_ingredients << ingredient.name if movie_ingredients.find_by(name: ingredient.name)
      end
      all_recipes_to_be_sorted << { ingredient_mentions: found_ingredients.length, name: recipe.name, ingredients: found_ingredients, id: recipe.id, per_ing_to_movie_ing: (( found_ingredients.length.to_f / movie_ingredients.length.to_f) * 100).to_f }
    end

    def vet_and_sort_recipes(all_recipes_to_be_sorted)
      vetted_recipes = all_recipes_to_be_sorted.select do |recipe| 
        recipe[:ingredient_mentions] > 1
      end
      vetted_and_sorted_recipes = vetted_recipes.sort_by {|recipe| recipe[:ingredient_mentions]}.reverse
      vetted_and_sorted_recipes
    end

    # generates list of ingredient objects ranked by mentions
    def rank_ingredients_by_ingredient_mentions
      ranked_ingredients_list = @movie.ingredients.each_with_object(Hash.new(0)){ |m,h| h[m] += 1 }.sort_by{ |key,value| -value }

      prettier_ranked_list = []
      ranked_ingredients_list.each do |ingredient_object|
        ingredient_object[0] = "#{ingredient_object[0][:name]}"
        ingredient_object[1] = "#{ingredient_object[1]} total mentions"
        percentage_of_all_ingredient_mentions = (ingredient_object[1].to_f / @movie.ingredients.length.to_f) * 100
        ingredient_object[2] = "#{percentage_of_all_ingredient_mentions}% vs. total" 
        prettier_ranked_list  << ingredient_object
      end
    end

  end
end

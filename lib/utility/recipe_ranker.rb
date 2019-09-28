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
      find_all_recipes_for_movie

      @recipes.each do |recipe|
        @movie.recipes << recipe
      end
    end

    # step 1, get all recipes with one ingredient mention in the movie
    def find_all_recipes_for_movie
      all_recipes = Recipe.all
      ingredients = @movie.ingredients

      @recipes = ingredients.each_with_object([]) do |ingredient, recipes|
        ingredient_name = ingredient.name
        
        recipes << all_recipes.select do |recipe|
          recipe_ingredients = recipe.ingredients.map { |ingredient| ingredient.name }
    
          recipe_ingredients.include?(ingredient_name)
        end
      end.flatten.uniq
      # creates the association
      @recipes.each do |recipe|
        @movie.recipes << recipe if !@movie.recipes.find_by(id: recipe.id)
      end
    end

    def rank_recipes_by_ingredient_mentions
      find_all_recipes_for_movie if @movie.recipes.length

      movie_ingredients = @movie.ingredients
      movie_recipes = @movie.recipes
      recipe_ranking = []

      movie_recipes.each do |recipe|
        ingredient_store = []
        recipe.ingredients.each do |ingredient|
          ingredient_store << ingredient.name if @movie.ingredients.find_by(name: ingredient.name)
        end
        recipe_ranking << { ingredient_mentions: ingredient_store.length, name: recipe.name, ingredients: ingredient_store, id: recipe.id, per_ing_to_movie_ing: (( ingredient_store.length.to_f / movie_ingredients.length.to_f) * 100).to_f }
      end
      vetted_recipes = recipe_ranking.select do |recipe| 
        recipe[:ingredient_mentions] > 1
      end
      sorted_recipes = vetted_recipes.sort_by {|recipe| recipe[:ingredient_mentions]}.reverse
      sorted_recipes
    end

    def ranking_ingredients_by_ingredient_mentions
      movie_ingredients = @movie.ingredients

      ranked_ingredients_list = movie_ingredients.each_with_object(Hash.new(0)){ |m,h| h[m] += 1 }.sort_by{ |key,value| -value }

      ranked_ingredients_list
    end

    # def calculate_percentage_of_recipe_ingredients_in_movie_ingredients(recipe)
    #   movie_ingredients = @movie.ingredients

    #   recipe_ingredients = recipe.ingredients.map {|ingredient| 
    #   ingredient if movie_ingredients.find_by(name: ingredient.name) 
    #   }
    #   percentage = (recipe_ingredients.length.to_f / movie_ingredients.length.to_f) * 100
    #   percentage
    # end

  end
end

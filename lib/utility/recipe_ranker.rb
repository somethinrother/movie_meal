# frozen_string_literal: true

module Utility
  class RecipeRanker
    attr_accessor :movie

    def initialize(movie)
      @movie = movie
    end

    def create_movie_recipes_associations
      movie_ingredients = @movie.ingredients
      recipes = Recipe.all
      recipes.each do |recipe|
        recipe_ingredients = recipe.ingredients
        shared_ingredients = (recipe_ingredients & movie_ingredients)
        mentions = shared_ingredients.map(&:name)
        next unless shared_ingredients.length > 1

        movie_recipe = MoviesRecipesAssociation.new(
          movie: @movie,
          recipe: recipe,
          mentions: mentions,
          mentions_percentage: ((shared_ingredients.length.to_f / movie_ingredients.length.to_f).to_f * 100)
        )
        movie_recipe.save if movie_recipe.valid?
        puts "Saved TITLE:#{movie.title} & RECIPE: #{recipe.name} #{shared_ingredients}"
      end
    end
  end
end

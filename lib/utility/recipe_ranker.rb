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
        shared_ingredients = ( recipe_ingredients & movie_ingredients )

        # Find out if the recipe shares more than two ingredients with movie_ingredients
        if (shared_ingredients.length > 2)
          movie_recipe = MoviesRecipesAssociation.new({movie: @movie, recipe: recipe, mentions: shared_ingredients, mentions_percentage: (shared_ingredients.length / movie_ingredients.uniq.length)})
          movie_recipe.save if movie_recipe.valid?

          puts "Saved TITLE:#{movie.title} & RECIPE: #{recipe.name} #{shared_ingredients}"
        end
      end

    end

  end
end
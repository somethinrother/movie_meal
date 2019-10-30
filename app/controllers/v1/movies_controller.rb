class V1::MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: {
      movies: movies
    }.to_json
  end

  def show
    movie = Movie.find(params[:id])
    movie_ingredients = movie.ingredients

    if movie_ingredients.empty?
      script_scanner = Utility::ScriptScanner.new
      script_scanner.get_ingredients_from_script(movie)
      ingredient_ranker = Utility::IngredientParser.new(movie)
      ingredient_ranker.create_movie_ingredients_associations
    end
    
    # output sorted ingredients array
    movie_ingredients_associations = MoviesIngredientsAssociation.all.select { |ingredient|
      ingredient.movie === movie
    }
    sorted_movie_ingredients = movie_ingredients_associations.sort_by {|recipe_association| recipe_association.mentions.length}.reverse
    shape_movie_ingredients_data = sorted_movie_ingredients.map{ |association| [association, association.recipe] }
    
    # output sorted recipes array
    
    movie_recipes = MoviesRecipesAssociation.all.select { |recipe|
      recipe.movie === movie
    }
    if movie_recipes.empty?
      recipe_ranker = Utility::RecipeRanker.new(movie)
      recipe_ranker.create_movie_recipes_associations
    end

    sorted_movie_recipes = movie_recipes.sort_by {|recipe_association| recipe_association.mentions.length}.reverse
    shape_movie_recipes_data = sorted_movie_recipes.map{ |association| [association, association.recipe] }
    
    render json: {
      movie: movie,
      ingredient_map: shape_movie_ingredients_data,
      recipe_map: shape_movie_recipes_data
    }
  end
end

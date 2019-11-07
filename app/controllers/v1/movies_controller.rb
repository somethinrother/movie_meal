class V1::MoviesController < ApplicationController
  def index
    movies = Movie.all
    movies.select {|movie| !movie.script.nil? }

    render json: {
      movies: movies
    }.to_json
  end

  def show
    movie = Movie.find(params[:id])
    movie_ingredients = movie.ingredients
    movie_ingredients_associations = find_or_populate_movie_ingredients_associations(movie)

    if movie_ingredients.empty?
      script_scanner = Utility::ScriptScanner.new
      script_scanner.get_ingredients_from_script(movie)
    end
    
    # sort ingredient mentions
    sorted_movie_ingredients = movie_ingredients_associations.sort_by {|association| association.mentions}.reverse
    shape_movie_ingredients_data = sorted_movie_ingredients.map{ |association| [association, association.ingredient.name] }

    # select recipe mentions
    movie_recipes = MoviesRecipesAssociation.all.select { |association| association.movie === movie }
    if movie_recipes.empty?
      recipe_ranker = Utility::RecipeRanker.new(movie)
      recipe_ranker.create_movie_recipes_associations
    end
    movie_recipes = MoviesRecipesAssociation.all.select { |association| association.movie === movie }

    # sort for output
    sorted_movie_recipes = movie_recipes.sort_by {|recipe_association| recipe_association.mentions.length}.reverse
    shape_movie_recipes_data = sorted_movie_recipes.map{ |association| [association, association.recipe.name] }
    
    render json: {
      movie: movie,
      ingredient_map: shape_movie_ingredients_data,
      recipe_map: shape_movie_recipes_data
    }
  end

  private

  def find_or_populate_movie_ingredients_associations(movie)
    movie_associations = MoviesIngredientsAssociation.where(movie: movie)

    if movie_associations.empty?
      ingredient_ranker = Utility::IngredientParser.new(movie)
      ingredient_ranker.create_movie_ingredients_associations
    end

    MoviesIngredientsAssociation.where(movie: movie)
  end
end

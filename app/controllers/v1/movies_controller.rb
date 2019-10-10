class V1::MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: {
      movies: movies
    }.to_json
  end

  def show
    movie = Movie.find(params[:id])
    recipes = MoviesRecipesAssociations.select do |recipe|
      recipe.movie === movie
    end
    sorted_recipes = recipes.sort_by {|recipe| recipe[:mentions_percentage]}.reverse
    put_both_arrays_together = sorted_recipes.map{ |association| [association, association.recipe] }
    render json: {
      movie: movie,
      ingredients: movie.ingredients,
      recipe_map: put_both_arrays_together
    }
  end
end

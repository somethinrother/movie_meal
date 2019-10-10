class V1::MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: {
      movies: movies
    }.to_json
  end

  def show
    movie = Movie.find(params[:id])
    recipes = MoviesRecipesAssociations.select do |association|
      association.movie === movie
    end
    sorted_recipes = recipes.sort_by {|recipe| recipe[:mentions_percentage]}.reverse

    render json: {
      movie: movie,
      ingredients: movie.ingredients,
      recipes: sorted_recipes
    }
  end
end

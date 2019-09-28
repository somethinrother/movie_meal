class V1::MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: {
      movies: movies
    }.to_json
  end

  def show
    movie = Movie.find(params[:id])
    render json: {
      movie: movie,
      ingredients: movie.ingredients,
      recipes: movie.recipes
    }
  end
end

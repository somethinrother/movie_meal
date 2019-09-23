class V1::MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: {
      movies: movies
    }.to_json
  end

  def show
    movies = Movie.all
    render json: {
      movie: movies.find(movieId)
  }.to_json
  end

end

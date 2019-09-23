class V1::MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: {
      movies: movies
    }.to_json
  end

  def show
    selectedMovie = Movie.find(id)
    render json: {
      selectedMovie: selectedMovie
  }.to_json
  end

end

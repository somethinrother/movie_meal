class V1::MoviesController < ApplicationController
  include MoviesDisplayMethods

  def index
    movies = Movie.all
    movies.reject { |movie| movie.script.nil? }

    render json: {
      movies: movies
    }.to_json
  end

  def show
    movie = Movie.find(params[:id])
    render json: {
      movie: movie
    }.to_json
  end
end

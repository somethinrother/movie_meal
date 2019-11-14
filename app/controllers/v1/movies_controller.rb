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
    render json: prepare_json_response(params[:id])
  end
end

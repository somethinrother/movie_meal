class V1::MoviesController < ApplicationController
  before_action :set_movie, only: [:show]
  before_action :populate_ingredients, only: [:show]
  before_action :populate_recipes, only: [:show]
  include MoviesDisplayMethods

  def index
    render json: index_page_json
  end

  def show
    render json: show_page_json(params[:id])
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end
end

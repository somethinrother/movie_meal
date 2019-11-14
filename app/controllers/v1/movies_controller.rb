class V1::MoviesController < ApplicationController
  include MoviesDisplayMethods

  def index
    render json: index_page_json
  end

  def show
    render json: show_page_json(params[:id])
  end
end

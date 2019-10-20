class V1::RecipesController < ApplicationController
  def index
    recipes = Recipe.all
    render json: {
      recipes: recipes
    }.to_json
  end
end

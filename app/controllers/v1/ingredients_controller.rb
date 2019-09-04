class V1::IngredientsController < ApplicationController
  def index
    ingredients = Ingredient.all
    render json: {
      ingredients: ingredients
    }.to_json
  end

  def show
    ingredient = Ingredient.find(params['id'])
    render json: {
      ingredients: ingredients
    }.to_json
  end
end

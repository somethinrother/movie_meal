class V1::MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: {
      movies: movies
    }.to_json
  end

  def show
    movie = Movie.find(params[:id])
    recipes = MoviesRecipesAssociations.select do |recipe|
      recipe.movie === movie
    end
    sorted_recipes = recipes.sort_by {|recipe| recipe[:mentions_percentage]}.reverse
    put_both_mov_rec_together = sorted_recipes.map{ |association| [association, association.recipe] }

    movie_ingredients = MoviesIngredientsAssociations.select do |ingredient|
      ingredient.movie === movie
    end
    sorted_ingredients = movie_ingredients.sort_by {|recipe| recipe[:mentions_percentage]}.reverse
    put_both_mov_ing_together = sorted_ingredients.map{ |association| [association, association.ingredient] }

    render json: {
      movie: movie,
      ingredients: put_both_mov_ing_together,
      recipe_map: put_both_mov_rec_together
    }
  end
end

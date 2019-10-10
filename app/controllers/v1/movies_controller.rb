class V1::MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: {
      movies: movies
    }.to_json
  end

  def show
    movie = Movie.find(params[:id])
    recipes = MoviesRecipesAssociations.select do |entry|
      entry[:movie_id] === movie.id
      
    end
    sorted_recipes = recipes.sort_by {|recipe| recipe[:mentions_percentage]}.reverse
    find_recipes = sorted_recipes.map {|recipe| Recipe.find(recipe.id)}

    render json: {
      movie: movie,
      ingredients: movie.ingredients,
      sorted_recipes: sorted_recipes,
      recipes: find_recipes
    }
  end
end

# Methods to prep movie data for display in React

module MoviesDisplayMethods
  def prepare_json_response(movie)
    {
      movie: movie,
      ingredients: movie.ingredients.uniq,
      recipes: movie.movies_recipes_associations.map { |association| association.recipe },
      ingredient_metadata: movie.movies_ingredients_associations,
      recipe_metadata: movie.movies_recipes_associations
    }.to_json
  end

  private

  def find_or_populate_movie_ingredients(movie)
    movie_ingredients = MoviesIngredientsAssociation.where(movie: movie)

    if movie_ingredients.empty?
      ingredient_ranker = Utility::IngredientParser.new(movie)
      ingredient_ranker.create_movie_ingredients_associations
      movie_ingredients = MoviesIngredientsAssociation.where(movie: movie)
    end

    prepare_movie_ingredients_for_display(movie_ingredients)
  end

  def prepare_movie_ingredients_for_display(movie_ingredients)
    sorted_movie_ingredients = movie_ingredients.sort_by(&:mentions).reverse
    sorted_movie_ingredients.map { |association| [association, association.ingredient.name] }
  end

  def find_or_populate_movie_recipes(movie)
    movie_recipes = MoviesRecipesAssociation.where(movie: movie)

    if movie_recipes.empty?
      recipe_ranker = Utility::RecipeRanker.new(movie)
      recipe_ranker.create_movie_recipes_associations
      movie_recipes = MoviesRecipesAssociation.where(movie: movie)
    end

    prepare_movie_recipes_for_display(movie_recipes)
  end

  def prepare_movie_recipes_for_display(movie_recipes)
    sorted_movie_recipes = movie_recipes.sort_by { |movie_recipe| movie_recipe.mentions.length  }.reverse
    sorted_movie_recipes.map { |association| [association, association.recipe.name] }
  end
end
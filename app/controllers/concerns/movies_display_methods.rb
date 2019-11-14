# Methods to prep movie data for display in React

module MoviesDisplayMethods
  def prepare_json_response(id)
    movie = fetch_movie(id)
    {
      movie: fetch_movie(id),
      ingredients: movie.ingredients.uniq,
      recipes: movie.movies_recipes_associations.map(&:recipe),
      ingredient_metadata: movie.movies_ingredients_associations,
      recipe_metadata: movie.movies_recipes_associations
    }.to_json
  end

  def fetch_movie(id)
    exclude_columns = %w[url script filtered_script created_at updated_at is_scraped]
    columns = Movie.attribute_names - exclude_columns

    Movie.select(columns).find(id)
  end

  private
end 
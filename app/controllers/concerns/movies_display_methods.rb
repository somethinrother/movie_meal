# Methods to prep movie data for display in React

module MoviesDisplayMethods
  MOVIE_EXCLUDE_COLUMNS = %w[url script filtered_script created_at updated_at].freeze

  def index_page_json
    {
      movies: fetch_all_movies
    }.to_json
  end

  def show_page_json(id)
    movie = fetch_movie(id)
    {
      movie: fetch_movie(id),
      ingredients: movie.ingredients.uniq,
      recipes: movie.movies_recipes_associations.map(&:recipe),
      ingredient_metadata: movie.movies_ingredients_associations,
      recipe_metadata: movie.movies_recipes_associations
    }.to_json
  end

  private

  def fetch_all_movies
    columns = Movie.attribute_names - MOVIE_EXCLUDE_COLUMNS

    Movie.select(columns).select(&:is_scraped)
  end

  def fetch_movie(id)
    columns = Movie.attribute_names - MOVIE_EXCLUDE_COLUMNS

    Movie.select(columns).find(id)
  end
end

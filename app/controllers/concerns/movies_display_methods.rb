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
      movie: movie,
      ingredients: prepare_ingredients(movie.movies_ingredients_associations),
      recipes: movie.movies_recipes_associations.map(&:recipe),
      ingredient_metadata: movie.movies_ingredients_associations,
      recipe_metadata: movie.movies_recipes_associations
    }.to_json
  end

  private

  def populate_ingredients(movie)
    if movie.movies_ingredients_associations.empty?
      ingredient_ranker = Utility::IngredientParser.new(movie)
      ingredient_ranker.create_movie_ingredients_associations
    end
  end

  def populate_recipes(movie)
    if movie.movies_recipes_associations.empty?
      recipe_ranker = Utility::RecipeRanker.new(movie)
      recipe_ranker.create_movie_recipes_associations
    end
  end

  def prepare_ingredients(ingredients_metadata)
    ingredients_metadata.as_json.map do |ingredient_metadata|
      id = ingredient_metadata['id']
      ingredient = Ingredient.find(id)
      ingredient_metadata['name'] = ingredient.name
      ingredient_metadata
    end
  end

  def fetch_all_movies
    columns = Movie.attribute_names - MOVIE_EXCLUDE_COLUMNS

    Movie.select(columns).select(&:is_scraped)
  end

  def fetch_movie(id)
    columns = Movie.attribute_names - MOVIE_EXCLUDE_COLUMNS

    movie = Movie.select(columns).find(id)
    populate_ingredients(movie)
    populate_recipes(movie)
    movie
  end
end

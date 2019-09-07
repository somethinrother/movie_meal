require 'utility/script_scanner'

module Utility
  class RecipeRanker
    
  # utility = Utility::RecipeRanker.query_search_for("Godfather")
  # If recipe is found for first ingredient, take that recipe and iterate over all the movie ingredients to see how many movie.ingredients that recipe contains, validating recipe for uniqueness
  # super inefficient algorithm
  def search(movie_search)
    movie = Movie.all.find_by(title: movie_search)
    if movie
      rank_recipes_by_ingredient_mentions(movie)
    else
      puts "There is no movie by those search terms"
    end
  end

  # movie IN, ranked recipes array based on ingredient_mentions OUT 
  def rank_recipes_by_ingredient_mentions(movie)
    check_for_script_and_scrape_ingredients(movie)
    recipes_array = []

    movie.ingredients.all.each do |ingredient|
      Recipes.all.each do |recipe|
        check_recipe_for_all_ingredient_mentions(recipes_array, recipe, movie)
      end
    end
    recipes_array.sort_by { |recipe| recipe[:match_percentage] }
    recipes_array.reverse
    puts recipes_array
  end

  def check_recipe_for_all_ingredient_mentions(recipes_array, recipe, movie)
    if recipe.ingredients.find_by(name: ingredient) && !recipes_array.include(recipe_name)
      recipe_name = recipe.name.to_s
      recipe_name = { 
        name: recipe.name,
        ingredients_mentioned: [ ingredient ],
        match_percentage: nil
      }
      movie_ingredients.all.each do |movie_ing|
        found_ingredient = recipe.ingredients.find_by(name: movie_ing.name)
        recipe_name[:ingredients_mentioned] << found_ingredient if found_ingredient
      end
      calculate_percentage_of_recipe_ingredients_to_movie_ingredients(recipe_name)
      recipes_array << recipe_name
    end
  end

  def check_for_script_and_scrape_ingredients(movie)
    get_script(movie) if !movie[:is_scraped]
    scan_script(movie)
  end

  def calculate_percentage_of_recipe_ingredients_to_movie_ingredients(recipe_object)
    all_movie_ingredients = movie_ingredients.length
    ingredients_mentioned = recipe[:ingredients_mentioned].length
    percentage = (ingredients_mentioned / all_movie_ingredients) * 100
    recipe[:match_percentage] = percentage
  end
  
  end
end
  
# new = Utility::RecipeRanker.new
# new.search("Godfather")

# make dispatch action

# 1. Query rails api for v1/movies that match input, and return the match
# 2. if it is not filled out, trigger a scrape
# 3. launch Loading screen
# 4. scrape script for all movie details, put into state
# 5. scrape script for all ingredients, put into state
# 6. load movie.ingredients list by default in List Container


# Search Bar Component:
# STEP 1: query the rails api for any movies that match it first, and return those. 
# STEP 2: If it doesn't find the movie filled out, then it has to do the full scrape
# STEP 3: Displays movie details
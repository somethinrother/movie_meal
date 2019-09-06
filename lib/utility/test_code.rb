require 'utility/script_scanner'

module Utility
  class RecipeRanker

  movie_ingredients = Movie.ingredients.all
  all_recipes = Recipes.all
    
  # Dave's idea #2
  # If recipe is found for first ingredient, take that recipe and iterate over all the movie ingredients to see how many movie.ingredients that recipe contains, validating recipe for uniqueness

  def query_search_for_movie(search_string)
    movie = Movie.all.find_by(name: search_string.to_s)
    if movie
      rank_recipes_by_ingredient_mentions(movie)
    else
      puts "There is no movie by those search terms"
    end
  end

  # in movie, out ranked recipes array with ingredient mentions
  def rank_recipes_by_ingredient_mentions(movie)
    recipes_mentioned = []

    get_script(movie) if !movie[:is_scraped]
    scan_script(movie)

    movie_ingredients = movie_ingredients.all
    movie_ingredients.each do |ingredient|
      all_recipes.each do |recipe|
        recipe_name = recipe.name.to_s
        # if recipe matches, iterate all movie.ing to check
        if recipe.ingredients.find_by(name: ingredient) && !recipes_mentioned.include(recipe_name)
          recipe_name = { 
            name: recipe.name,
            ingredients_mentioned: [ ingredient ]
            match_percentage: nil
          }
          movie_ingredients.each do |movie_ing|
            found_ingredient = recipe.ingredients.find_by(name: movie_ing.name)
            recipe_name[:ingredients_mentioned].shift(found_ingredient) if found_ingredient
          end
          recipes_mentioned << recipe_name
          calculate_percentage_of_recipe_ingredients_to_movie_ingredients(recipe_name)
        end
      end
    end
    recipes_mentioned.sort_by { |recipe| recipe[:match_percentage] }
    recipes_mentioned.reverse
    puts recipes_mentioned
  end

  def calculate_percentage_of_recipe_ingredients_to_movie_ingredients(recipe)
    all_movie_ingredients = movie_ingredients.length
    ingredients_mentioned = recipe[:ingredients_mentioned].length
    percentage = (ingredients_mentioned / all_movie_ingredients) * 100
    recipe[:match_percentage] = percentage
  end
  
  end
end
  
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
# Dave's idea number 1

recipes_mentioned = []

Movie.ingredients.all.each do |ingredient|
  Recipes.all.each do |recipe|
    if (recipe.ingredients.find_by(name: ingredient) && recipes_mentioned.find_by(name: recipe.name)) {
      [recipe.name][ingredients_mentioned] = ingredient
    elsif recipe.ingredients.find_by(name: ingredient) 
      recipe.name = { 
        name: recipe.name,
        id: recipe.id,
        ingredients_mentioned: [ ingredient ]
      }
      recipes_mentioned.push([recipe.name])
    end
  end
end

# Dave's idea #2

all_recipes = Recipes.all
movie_ingredients = Movie.ingredients.all
recipes_mentioned = []

movie_ingredients.all.each do |ingredient|
  all_recipes.each do |recipe|
    if (recipe.ingredients.find_by(name: ingredient)
      [recipe.name] = { 
        name: recipe.name,
        id: recipe.id,
        ingredients_mentioned: [ ingredient ]
      }
      movie_ingredients.all.each do |movie_ing|
        found_ingredient = recipe.ingredients.find_by(name: movie_ing.name)
        if found_ingredient
          [recipe.name][ingredients_mentioned] = found_ingredient 
          recipes_mentioned << [recipe.name]
        end
      end
    end
  end
end


# James' code for calculating percentage of ingredients that appear in recipe, etc
movie_ingredients = Movie.ingredients.all
searched_ingredients = params(ingredients)

original_length = movie_ingredients.length
unmatched_ingredients = Movie.ingredients.all.to_a - searched_ingredients

num_of_matched = original_length - unmatched_ingredients.length
match_percentage = (num_of_matched / original_length) * 100



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
require 'utility/imsdb_parser'

module Utility
	class ScriptScanner
		def populate_all_scripts
			Movie.all.each do |movie|
				get_script(movie)
			end
		end

		def scan_all_scripts
			movies = Movie.all
			movies.each do |movie|
				scan_script(movie)
			end
		end

		def	scan_script(movie)
			get_script(movie) if movie.is_scraped === false
			if movie.is_scraped
				words = movie.script.split(' ')
				words.each do |word|
					ingredient = Ingredient.find_by(name: word)
					movie.ingredients << ingredient unless ingredient.nil?
				end
			end
		end

		def get_script(movie)
			parser = Utility::ImsdbParser.new
			parser.populate_script(movie)
		end

		# INITIAL SEEDING
		def find_all_recipes_all_movies
			all_recipes = Recipe.all
			all_movies = Movie.all
			all_movies.each do |movie|
				movie_ingredients = movie.ingredients
				movie_recipes = movie_ingredients.each_with_object([]) do |ingredient, recipes|
					ingredient_name = ingredient.name
					recipes << all_recipes.select do |recipe|
						recipe_ingredients = recipe.ingredients.map { |ingredient| ingredient.name }
						
						recipe_ingredients.include?(ingredient_name)
					end
				end.flatten.uniq
				create_movie_recipes_associations(movie_recipes)
			end
		end

		def create_movie_recipes_associations(movie_recipes)
			movie_recipes.each do |recipe|
				movie.recipes << recipe if !movie.recipes.find_by(id: recipe.id)
			end
		end

	end
end
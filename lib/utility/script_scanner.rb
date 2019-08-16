require 'utility/imsdb_parser'

module Utility
	class ScriptScanner

		def populate_all_scripts
			Movie.all.each do |movie|
				scan_script(movie.title)
			end
		end

		def get_script(movie)
			return NoMovieExists unless movie

			parser = Utility::ImsdbParser.new
			parser.populate_script(movie)
		end

		def	scan_script(movie)
			get_script(movie) if movie.is_scraped == false

			words = movie.script.split(' ')
			words.each do |word|
				movie.ingredients << Ingredient.find_by(name: word) unless Ingredient.find_by(name: word).nil?
				movie.recipes << Recipe.find_by(name: word) unless Recipe.find_by(name: word).nil?
			end
		end

# Goes on forever
		# def check_all_for_food(number)
		# 	counter = 0
		# 	 if counter < number
		# 		Movie.all.each do |movie|
		# 			if movie.ingredients.all && movie.is_scraped
		# 				counter += 1
		# 				scan_script(movie)
		# 				display_ingredients(movie)
		# 			end
		# 		end
		# 	end
		# end

		def display_food(movie_title)
			movie = Movie.find_by(title: movie_title)
			scan_script(movie)
			display_recipes(movie)
			display_ingredients(movie)
		end

		def display_recipes(movie)
			unique_recipes = []
			movie.recipes.all.each do |recipe|
				unique_recipes << recipe.name
			end
			puts "#{movie.title} contains: #{unique_recipes.to_s}"
		end

		def display_ingredients(movie)
			unique_ingredients = []
			movie.ingredients.all.each do |ingredient|
				unique_ingredients << ingredient.name unless unique_ingredients.include?(ingredient.name)
			end
			puts "#{movie.title} contains: #{unique_ingredients.to_s}"
		end

		def display_all_movies_with_script
			movies = Movie.all
			movies.each do |movie|
				check_for_script(movie)
			end
		end

		def check_for_script(movie)
			puts "#{movie.title} has a script"	if movie.script
			puts "#{movie.title} does not have a script" if movie.script == nil?
		end

	end
end

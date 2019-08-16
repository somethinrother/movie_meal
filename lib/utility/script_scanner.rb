require 'utility/imsdb_parser'

module Utility
	class ScriptScanner

		def populate_all_scripts
			Movie.all.each do |movie|
				scan_script(movie.title)
			end
		end

		def get_script(movie)
		  movie = Movie.find_by(title: movie)
			return NoMovieExists unless movie

			parser = Utility::ImsdbParser.new
			parser.populate_script(movie)
		end

		def	scan_script(movie)
			return NoMovieScript if movie.script.nil?

			words = movie.script.split(' ')
			words.each do |word|
				movie.ingredients << Ingredient.find_by(name: word) unless Ingredient.find_by(name: word).nil?

				movie.recipes << Recipe.find_by(name: word) if !(Recipe.find_by(name: word).nil?)
			end
		end

# can alter return data type, right now is an array for proof of concept
		def movies_check_for_food(number)
			counter = 0
			Movie.all.each do |movie|
				if movie.is_scraped && has_any_food(movie) && counter < number
						scan_script(movie)
						# display_recipes(movie)
						counter += 1
						display_ingredients(movie)
				end
			end
		end

		def has_any_food(movie)
			movie.ingredients.all || movie.recipes.all
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

# METHODS FOR FINDING ERRORS AND INFORMATION
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

		# def all_movies_display_all_food
		# 	Movie.all.each do |movie|
		# 		if has_any_food(movie)
		# 			display_ingredients(movie)
		# 		end
		# 	end
		# end

	end
end

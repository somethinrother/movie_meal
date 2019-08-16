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
			if movie.ingredients.first
				movie.ingredients.each do |ingredient|
					ingredient
				end
			end
			if movie.recipes.first
				movie.recipes.each do |recipe|
					recipe
				end
			end
		end

# METHODS FOR FINDING ERRORS AND INFORMATION
		def check_for_all_scripts
			movies = Movie.all
			movies.each do |movie|
				puts "#{movie.title} has a script" if movie.script
				puts "#{movie.title} ... NO script" if movie.script == nil?
			end
		end

# need to fix the out put of these methods so its not array return
# 	movie = Movie.find_by(title: movie)

# need to fix the out put of these methods so its not array return
		def check_for_food_loop(number)
			counter = 0
			Movie.all.each do |movie|
				if movie.is_scraped && counter < number
					scan_script(movie)
					if has_any_food(movie)
						counter += 1
						check_for_ingredient_mentions(movie)
					end
				end
			end
		end

		def has_any_food(movie)
			return true	if movie.ingredients.all || movie.recipes.all
		end

		def check_for_ingredient_mentions(movie)
			if has_any_food(movie)
				ingredients = []
				movie.ingredients.all.each do |ingredient|
					ingredients << ingredient.name unless ingredients.include?(ingredient)
				end
				movie.recipes.all.each do |recipe|
					ingredients << recipe.name
				end
				return ingredients
			end
		end

	end
end

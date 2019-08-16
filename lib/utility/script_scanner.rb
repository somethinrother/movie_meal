require 'utility/imsdb_parser'

module Utility
	class ScriptScanner

		def get_script_and_scan(movie)
		  movie_found = Movie.find_by(title: movie)
			return NoMovieExists unless movie_found

			parser = Utility::ImsdbParser.new
			parser.populate_script(movie_found) if !(movie_found.script.nil?)
			
			scan_for_recipes_and_ingredients(movie_found)
		end

		def	scan_for_recipes_and_ingredients(movie)
			words = movie[:script].split(' ')
			words.each do |word|
				byebug
				movie.ingredients << Ingredient.find_by(name: word) if (Ingredient.find_by(name: word).nil?)

				movie.recipes << Recipe.find_by(name: word) if !(Recipe.find_by(name: word).nil?)
			end
		end
	end
end

# Movie.script_scanner.get_script_and_scan("10 Things I Hate About You")

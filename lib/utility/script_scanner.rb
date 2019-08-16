module Utility
	class ScriptScanner

		def get_script_and_scan(movie)
		  movie_found = Movie.find(name: movie)
			populate_script(movie_found) if movie_found
			scan_for_recipes_and_ingredients(movie_found)
		end

		def	scan_for_recipes_and_ingredients(movie)
			movie[:script].each do |word|
				movie.ingredients << Ingredient.find_or_create_by(name: word)

				movie.recipes << Recipe.find_or_create_by(name: word)
			end
		end

	end
end

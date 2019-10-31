require 'utility/imsdb_parser'

module Utility
	class ScriptScanner

		def	get_ingredients_from_script(movie)
			get_script(movie) if !movie.is_scraped
			puts "#{movie.title} has no script." if movie.script.nil?

			if movie.is_scraped
				words = movie.script.split(' ')
				words.each do |word|
					ingredient = Ingredient.find_by(name: word)
					movie.ingredients << ingredient unless ingredient.nil?
					print "#{ingredient.name} " if movie.ingredients.include?(ingredient)
				end
			end
		end

		def get_script(movie)
			parser = Utility::ImsdbParser.new
			parser.populate_script(movie) if !movie.is_scraped
		end

	end
end
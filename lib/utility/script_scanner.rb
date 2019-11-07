require 'utility/imsdb_parser'

module Utility
	class ScriptScanner
		
		def get_scripts_for_movies_array(movies_by_character)
			movies_by_character.each do |movie|
				puts "got script for: #{movie.title}" if movie.is_scraped
				get_script(movie) if !movie.is_scraped
			end
		end

		def get_movies_by_character(character)
			puts "in get movies by character: #{character}"
			all_movies = Movie.all
			movies_by_character = all_movies.select { |movie| movie.title[0].downcase === character.to_s}
			# puts movies_by_character
		end

		def get_script(movie)
			parser = Utility::ImsdbParser.new
			parser.populate_script(movie) if !movie.is_scraped
		end

		def	get_ingredients_from_script(movie)
			get_script(movie) if !movie.is_scraped
			puts "#{movie.title} has no script." if movie.script.nil?
			puts "#{movie.title}" if movie.script
			
			if movie.is_scraped
				words = movie.script.split(' ')
				words.each do |word|
					ingredient = Ingredient.find_by(name: word)
					movie.ingredients << ingredient unless ingredient.nil?
					print "#{ingredient.name} " if movie.ingredients.include?(ingredient)
				end
			end
		end

	end
end
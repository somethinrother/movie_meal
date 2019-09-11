require 'utility/imsdb_parser'

module Utility
	class ScriptScanner
		def populate_all_scripts
			Movie.all.each do |movie|
				scan_script(movie.title)
			end
		end

		def	scan_script(movie)
			get_script(movie) if !movie.is_scraped

			words = movie.script.split(' ')
			words.each do |word|
				ingredient = Ingredient.find_by(name: word)
				movie.ingredients << ingredient unless ingredient.nil?
			end
		end

		def get_script(movie)
			parser = Utility::ImsdbParser.new
			parser.populate_script(movie)
		end

		# for error checking
		def display_all_movies_with_scripts
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

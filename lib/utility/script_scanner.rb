require 'utility/imsdb_parser'

module Utility
	class ScriptScanner
		def populate_all_scripts
			Movie.all.each do |movie|
				get_script(movie)
				puts "found script for #{movie}"
			end
		end

		def scan_all_scripts
			movies = Movie.all
			movies.each do |movie|
				scan_script(movie)
				puts "scanned script for #{movie}"
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

	end
end
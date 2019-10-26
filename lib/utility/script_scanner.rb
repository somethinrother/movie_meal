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
			get_script(movie) if !movie.is_scraped
			puts "#{movie.title} has no script." if movie.script.nil?

			if movie.is_scraped
				words = movie.script.split(' ')
				words.each do |word|
					ingredient = Ingredient.find_by(name: word)
					movie.ingredients << ingredient unless ingredient.nil?
					print "#{ingredient.name} " if movie.ingredients.include?(ingredient)
				end
				puts "#{movie.title}"
				if movie.ingredients
					movie.ingredients.uniq.each do |i|
						print "#{i.name} "
					end
				end
				# puts "scanned script for #{movie.title}"
			end

		end

		def get_script(movie)
			parser = Utility::ImsdbParser.new
			parser.populate_script(movie) if !movie.is_scraped
		end
	end
end
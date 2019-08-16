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
			movie = Movie.find_by(title: movie)
			return NoMovieScript if movie.script.nil?

			words = movie.script.split(' ')
			words.each do |word|
				movie.ingredients << Ingredient.find_by(name: word) unless Ingredient.find_by(name: word).nil?

				movie.recipes << Recipe.find_by(name: word) if !(Recipe.find_by(name: word).nil?)
			end
		end

# For error finding
		def check_for_all_scripts
			movies = Movie.all
			movies.each do |movie|
				puts "#{movie.title} has a script" if movie.script
				puts "#{movie.title} ... NO script" if movie.script.nil?
			end
		end


	end
end

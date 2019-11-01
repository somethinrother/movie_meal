require 'utility/script_scanner'

namespace :script_scanner do
  desc "Populate scripts for all movies"
  task :populate_all_scripts do |task, args|
    all_numbers = (1..9).to_a
    all_letters = ('a'..'z').to_a
    all_characters = all_numbers.concat(all_letters) 

    all_characters.each do |character|
      Rake::Task["script_scanner:populate_scripts_for_movies_with_character"].invoke(character) 
      Rake::Task["script_scanner:populate_scripts_for_movies_with_character"].reenable 
    end
  end

  desc "Populate scripts for movies_with_character, split up into multiple arrays"
  task :populate_scripts_for_movies_with_character, [:character] do |task, args|
    puts "task: #{args[:character]}"
    scanner = Utility::ScriptScanner.new
    movies_by_character = scanner.get_movies_by_character(args[:character])
    movies_by_character.each_slice(20) do |array_slice|
      Rake::Task["script_scanner:get_scripts_for_movies_array"].invoke(array_slice)
      Rake::Task["script_scanner:get_scripts_for_movies_array"].reenable
    end
  end

  task :get_scripts_for_movies_array, [:array] do |task, args|
    puts "in get_scripts_for_movies_array #{task}"
    scanner = Utility::ScriptScanner.new
    scanner.get_scripts_for_movies_array(args[:array])
  end




end




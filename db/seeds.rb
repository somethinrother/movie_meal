# Scrape all movies from IMSDB, without the scripts
imsdb_parser = Utility::ImsdbParser.new
imsdb_parser.scrape_all

# Save a large number of recipes and ingredients from Recipe Puppy
recipe_puppy_parser = Utility::RecipePuppyParser.new
recipe_puppy_parser.save_all_recipes_to_database
puts "All recipes and ingredients saved successfully"
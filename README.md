# README

STEPS TO SET UP
1. bundle exec rails db:setup
1. rails script_scanner:populate_all_scripts
1. rails script_scanner:get_all_ingredients
1. rails recipe_parser:get_movies_recipes_associations
1. rails recipe_parser:get_movies_ingredients_associations
1. Expect all the above steps to take quite some time. Over time this will hopefully be lessened.
1. Run `bundle exec rspec` to ensure the test suite passes
1. Ensure you have installed both the react & redux chrome extensions

STEPS TO RUN
1. In your first terminal window, run `bundle exec rails s` to serve the rails app on http://localhost:3000
1. Open a second terminal window and run `bundle exec ./bin/webpack-dev-server` to start the react app at the root
1. Visit http://localhost:3000 to visit the app

USEFUL COMMANDS
1. `rails generate react:component ComponentName propname:data_type` to create a new named react component with validated proptypes

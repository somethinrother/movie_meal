# README

STEPS TO SET UP
1. Run `bundle exec rails db:setup` to populate the database with movies, recipes, and ingredients. Expect this to take a little while.
1. Run `bundle exec rspec` to ensure the test suite passes
1. Ensure you have installed both the react & redux chrome extensions

STEPS TO RUN
1. In your first terminal window, run `bundle exec rails s` to serve the rails app on http://localhost:3000
1. Open a second terminal window and run `bundle exec ./bin/webpack-dev-server` to start the react app at the root
1. Visit http://localhost:3000 to visit the app

USEFUL COMMANDS
1. `rails generate react:component ComponentName propname:data_type` to create a new named react component with validated proptypes

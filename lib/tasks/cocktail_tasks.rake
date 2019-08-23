require File.expand_path('../../../config/environment', __FILE__)
require 'utility/cocktail_parser'

namespace :cocktail do
  desc "Scrape cocktails from cocktail_information assets"
  task :save_all do
    parser = Utility::CocktailParser.new
    parser.save_cocktails
  end
end

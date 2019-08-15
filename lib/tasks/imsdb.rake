require File.expand_path('../../../config/environment',  __FILE__)
require 'utility/imsdb_parser'

namespace :imsdb do
  desc "Scrape title, writers, year, & script url from IMSDB / all scripts page"
  task :scrape_all do
    movie_links = Utility::ImsdbParser.new.all_movie_page_links

    movie_links.each do |node|
      Movie.save_movie_from_imsdb_node(node)
    end
  end
end

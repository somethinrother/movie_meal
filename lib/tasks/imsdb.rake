require File.expand_path('../../../config/environment',  __FILE__)
require 'utility/imsdb_parser'

namespace :imsdb do
  desc "Scrape title, writers, year, & script url from IMSDB / all scripts page"
  task :scrape_all do
    parser = Utility::ImsdbParser.new
    parser.scrape_all
  end
end

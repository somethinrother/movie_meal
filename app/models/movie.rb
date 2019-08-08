require 'utility/imsdb_parser'

class Movie < ApplicationRecord
  validates :title, uniqueness: true
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :recipes

  def self.scrape_initial_movie_data
    imsdb = Utility::ImsdbParser.new
    movie_links = imsdb.all_movie_page_links

    movie_links.each do |node|
      url = imsdb.extract_script_url_from_node(node)
      title = attributes['title'].value
      # TODO: Create logic to find the writers, year, etc
      Movie.create({
        title: title,
        url: url
      })
      logger.info("Successfully saved #{title}")
    end
  end
  #
  # def self.populate_scripts
  #   Movie.all.each do |movie|
  #     html_body = HTTParty.get(movie.href).body
  #     movie.script = html_body
  #     movie.script = ActionController::Base.helpers.strip_tags(movie.script)
  #     movie.save
  #   end
  # end
end

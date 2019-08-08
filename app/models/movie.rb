require 'utility/imsdb_parser'

class Movie < ApplicationRecord
  validates :title, uniqueness: true
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :recipes

  def self.imsdb
    Utility::ImsdbParser.new
  end

  def self.create_movie_from_node(node)
    attributes = self.imsdb.extract_movie_data_from_node(node)
    # TODO: Create logic to find the writers, year, etc
    Movie.create({
      title: attributes[:title],
      url: attributes[:url]
    })
  end

  def self.scrape_initial_movie_data
    movie_links = self.imsdb.all_movie_page_links

    movie_links.each do |node|
      self.create_movie_from_node(node)
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

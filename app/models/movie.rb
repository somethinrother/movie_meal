require 'utility/imsdb_parser'

class Movie < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :recipes
  has_many :movies_recipes_associations

  def self.save_movie_from_imsdb_node(node)
    parser = Utility::ImsdbParser.new
    attributes = parser.extract_movie_data_from_node(node)

    movie = Movie.new({
      title: attributes[:title],
      url: attributes[:url],
      is_scraped: false
    })

    if movie.save
      puts "#{movie.title} was successfully saved"
    else
      puts "#{movie.title} could not be saved: #{movie.errors.full_messages}"
    end
  end
end

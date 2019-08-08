require 'utility/imsdb_parser'

class Movie < ApplicationRecord
  validates :title, uniqueness: true
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :recipes

  def self.scrape_initial_movie_data
    imsdb = Utility::ImsdbParser.new
    # extract tags from url & css path
    movie_tags = imsdb.extract_tags_from_css_at_url('table td p a', 'https://www.imsdb.com/all%20scripts/')
    # Iterate over those tags
    movie_data = movie_tags.map do |node|
      # Access the attributes of a given node
      attributes = node.attributes
      # Interpolate href attribute to get the landing page href
      landing_page_href = "https://www.imsdb.com#{attributes['href'].value}".gsub(' ', '%20')
      # extract tags from url & css path
      links = imsdb.extract_tags_from_css_at_url('.script-details td a', landing_page_href)
      # The script link is always the bottom one
      script_href = links[-1].attributes['href'].value
      # Interpolate the script href to obtain the script url
      href = "https://www.imsdb.com#{script_href}"
      # Extract the title from the node attributes
      title = attributes['title'].value
      # TODO: Create logic to find the writers, year, etc
      # Create a movie with the title and href
      Movie.create({
        title: title,
        href: href
      })
      # Log success message
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

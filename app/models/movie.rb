class Movie < ApplicationRecord
  validates :title, uniqueness: true
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :recipes

  def self.scrape_initial_movie_data
    html_body = HTTParty.get('https://www.imsdb.com/all%20scripts/').body
    body = Nokogiri::HTML(html_body)

    movie_data = body.css('table td p a').map do |node|
      attributes = node.attributes
      landing_page_href = "https://www.imsdb.com#{attributes['href'].value}".gsub(' ', '%20')

      landing_page = HTTParty.get(landing_page_href).body
      landing_page_html = Nokogiri::HTML(landing_page)
      links = landing_page_html.css('.script-details td a')
      script_href = links[-1].attributes['href'].value
      href = "https://www.imsdb.com#{script_href}"
      title = attributes['title'].value

      Movie.create({
        title: title,
        href: href
      })

      logger.info("Successfully saved #{title}")
      sleep 3
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

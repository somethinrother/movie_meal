module Utility
  class ImsdbParser
    IMSDB_BASE_URL='https://www.imsdb.com'.freeze
    ALL_SCRIPT_URL = "#{IMSDB_BASE_URL}/all%20scripts/".freeze
    SCRIPT_LINK_CSS_PATH='table td p a'.freeze
    LANDING_PAGE_CSS_PATH='.script-details td a'.freeze
    BLACKLISTED_EXTENSIONS = ['pdf'].freeze

    def scrape_all
      movie_links = all_movie_page_links

      movie_links.each do |node|
        Movie.save_movie_from_imsdb_node(node)
      end
    end

    def extract_movie_data_from_node(node)
      {
        title: extract_title_from_node(node),
        url: extract_script_url_from_node(node)
      }
    end

    def populate_script(movie)
      url_components = movie.url.split('.')
      return if BLACKLISTED_EXTENSIONS.any? {|extension| url_components.include?(extension) }
      script = HTTParty.get(movie.url).body
      # doesn't save if a PDF
      if script.nil?
        puts "#{movie.title} doesn't have readable script. Scraped = #{movie.is_scraped}"
      end

      if !script.nil?
        movie.assign_attributes(
          script: process_raw_script(script),
          is_scraped: true
        )
        movie.save
        puts "#{movie.title} has been created. Scraped = #{movie.is_scraped}"
      end
      

    end

    private

    def all_movie_page_links
      extract_tags_from_css_at_url(SCRIPT_LINK_CSS_PATH, ALL_SCRIPT_URL)
    end

    def extract_title_from_node(node)
      attributes = node.attributes
      title = attributes['title'].value
      # Regex to remove final word (Script)
      title[/(.*)\s/,1]
    end

    def extract_script_url_from_node(node)
      attributes = node.attributes
      href = attributes['href'].value.gsub(' ', '%20')
      landing_page_url = imsdb_url(href)
      links = extract_tags_from_css_at_url(LANDING_PAGE_CSS_PATH, landing_page_url)
      script_href = links[-1].attributes['href'].value
      imsdb_url(script_href)
    end

    def extract_tags_from_css_at_url(css_path, url)
      raw_body = HTTParty.get(url).body
      body = Nokogiri::HTML(raw_body)
      body.css(css_path)
    end

    def imsdb_url(path)
      "#{IMSDB_BASE_URL}#{path}"
    end

    def process_raw_script(script)
      ActionController::Base.helpers.strip_tags(script)
        .gsub(/[^a-zA-Z]/, ' ')
        .squish
        .downcase
    end
  end
end

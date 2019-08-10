module Utility
  class ImsdbParser
    IMSDB_BASE_URL='https://www.imsdb.com'.freeze
    ALL_SCRIPT_URL = "#{IMSDB_BASE_URL}/all%20scripts/".freeze
    SCRIPT_LINK_CSS_PATH='table td p a'.freeze
    LANDING_PAGE_CSS_PATH='.script-details td a'.freeze

    def all_movie_page_links
      extract_tags_from_css_at_url(SCRIPT_LINK_CSS_PATH, ALL_SCRIPT_URL)
    end

    def extract_movie_data_from_node(node)
      {
        title: extract_title_from_node(node),
        url: extract_script_url_from_node(node)
      }
    end


    def extract_title_from_node(node)
      attributes = node.attributes
      title = attributes['title'].value
      # Regex to remove final word (Script)
      byebug if title.split(' ').length == 1
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

    # def self.populate_scripts
    #   Movie.all.each do |movie|
    #     html_body = HTTParty.get(movie.href).body
    #     movie.script = html_body
    #     movie.script = ActionController::Base.helpers.strip_tags(movie.script)
    #     movie.save
    #   end
    # end
  end
end

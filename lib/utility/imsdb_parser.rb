module Utility
  class ImsdbParser
    ALL_SCRIPT_URL = 'https://www.imsdb.com/all%20scripts/'.freeze
    SCRIPT_LINK_CSS_PATH = 'table td p a'.freeze

    def all_movie_page_links
      extract_tags_from_css_at_url(SCRIPT_LINK_CSS_PATH, ALL_SCRIPT_URL)
    end

    def extract_script_url_from_node(node)
      attributes = node.attributes
      landing_page_href = "https://www.imsdb.com#{attributes['href'].value}".gsub(' ', '%20')
      links = extract_tags_from_css_at_url('.script-details td a', landing_page_href)
      script_href = links[-1].attributes['href'].value
      "https://www.imsdb.com#{script_href}"
    end

    def extract_tags_from_css_at_url(css_path, url)
      html = HTTParty.get(url).body
      body = Nokogiri::HTML(html)
      body.css(css_path)
    end
  end
end

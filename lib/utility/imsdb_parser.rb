module Utility
  class ImsdbParser
    IMSBD_BASE_URL='https://www.imsdb.com'.freeze
    ALL_SCRIPT_URL = "#{IMSBD_BASE_URL}/all%20scripts/".freeze
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
      attributes['title'].value
    end

    def extract_script_url_from_node(node)
      attributes = node.attributes
      landing_page_href = "#{IMSBD_BASE_URL}#{attributes['href'].value}".gsub(' ', '%20')
      links = extract_tags_from_css_at_url(LANDING_PAGE_CSS_PATH, landing_page_href)
      script_href = links[-1].attributes['href'].value
      "#{IMSBD_BASE_URL}#{script_href}"
    end

    def extract_tags_from_css_at_url(css_path, url)
      raw_body = HTTParty.get(url).body
      body = Nokogiri::HTML(raw_body)
      body.css(css_path)
    end
  end
end

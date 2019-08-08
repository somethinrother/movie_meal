module Utility
  class ImsdbParser
    ALL_SCRIPT_URL = 'https://www.imsdb.com/all%20scripts/'.freeze

    def extract_tags_from_css_at_url(css_path, url)
      html = HTTParty.get(url).body
      body = Nokogiri::HTML(html)
      body.css(css_path)
    end
  end
end

module Utility
	class CocktailParser

		BASE_URL = 'https://www.thecocktaildb.com/'.freeze
		API_URL = 'api/json/v1/1/lookup.php?i='.freeze
		BROWSING_URL = 'browse.php?b='.freeze
		DRINK_LINK_PATH = '#feature div div.center div.row div.col-sm-3 a'.freeze
		ALPHABET = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'].freeze

# scrape Cocktail Browsing url for cocktail IDs
		def initial_scrape_for_drink_ids
			ALPHABET.each do |letter|
				url = "#{BASE_URL}#{BROWSING_URL}#{letter}"
				nodeset = extract_links_from_css_at_url(DRINK_LINK_PATH, url)
				nodeset.each do |two_tags_one_drink|
					url = "#{BASE_URL}#{two_tags_one_drink.attributes['href'].value}"
					# regex for getting 5 digit cocktail ID
					cocktail_id = url.match('\d{5}')
					# taking the name from id, formatting it properly
					cocktail_name = url.match('-\b\D+\b.').to_s.gsub!(/^-/, '').gsub!(/-/, ' ')
					Cocktail.create(cocktail_id: cocktail_id, name: cocktail_name)
				end
			end
		end

# this method returns an array of drink_html_urls
		def get_drink_urls_by_letter(letter)
			links_to_drink = []
			url = "#{BASE_URL}#{BROWSING_URL}#{letter}"
			nodeset = extract_links_from_css_at_url(DRINK_LINK_PATH, url)
			nodeset.each do |two_tags_one_drink|
				links_to_drink <<	"#{BASE_URL}#{two_tags_one_drink.attributes['href'].value}"
			end
			links_to_drink
		end

		def extract_links_from_css_at_url(css_path, url)
			raw_body = HTTParty.get(url).body
			body = Nokogiri::HTML(raw_body)
			body.css(css_path)
		end

	end
end

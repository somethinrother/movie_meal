module Utility
	class CocktailParser

		BASE_URL = 'https://www.thecocktaildb.com'.freeze
		BASE_BROWSING_URL = 'https://www.thecocktaildb.com/browse.php?b='.freeze
		DRINK_LINK_PATH = '#feature div div.center div.row div.col-sm-3 a'.freeze
		ALPHABET = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'].freeze

		def browse_all_drinks
			all_drinks_list = []
			ALPHABET.each do |letter|
				url = "#{BASE_BROWSING_URL}#{letter}"
				nodeset = extract_links_from_css_at_url(DRINK_LINK_PATH, url)
				nodeset.each do |two_tags_one_drink|
					all_drinks_list << <<	"#{BASE_URL}#{two_tags_one_drink.attributes['href'].value}"
				end
			end
			all_drinks_list
		end

# this method returns an array of drink_query extensions
		def get_drink_urls_by_letter(letter)
			links_to_drink = []
			url = "#{BASE_BROWSING_URL}#{letter}"
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

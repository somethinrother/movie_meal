class Recipe < ApplicationRecord
	validates :title, uniqueness: true
end

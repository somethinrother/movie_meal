class Movie < ApplicationRecord
  validates :title, uniqueness: true
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :recipes

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

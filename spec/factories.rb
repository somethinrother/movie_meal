FactoryBot.define do
  factory :cocktail do
    
  end

  # FACTORIES

  factory :movie do
    title { generate(:movie_title) }
    writers { generate(:name) }
    year { 1984 }
    is_scraped { false }
  end

  factory :ingredient do
    name { generate(:name) }
  end

  factory :ingredient_mention do
    movie
    ingredient
  end

  factory :recipe do
    name { generate(:name) }
    thumbnail { 'generic thumbnail' }
  end

  # SEQUENCES

  sequence :movie_title do |n|
    "Movie Title #{n}"
  end

  sequence :name do |n|
    "name #{n}"
  end
end

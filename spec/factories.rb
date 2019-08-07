FactoryBot.define do
  factory :ingredient_mention do
    
  end

  sequence :movie_title do |n|
    "Movie Title #{n}"
  end

  sequence :name do |n|
    "name #{n}"
  end

  factory :movie do
    title { generate(:movie_title) }
    writers { generate(:name) }
    year { 1984 }
    is_scraped { false }
  end

  factory :ingredient do
    name { generate(:name) }
  end
end

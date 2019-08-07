FactoryBot.define do
  factory :ingredient do
    name { generate(:name) }
  end

  factory :ingredient_mention do
    movie { generate(:movie_id)}
    ingredient { generate(:ingredient_id) }
  end

  sequence :movie_title do |n|
    "Movie Title #{n}"
  end

  factory :movie do
    title { generate(:movie_title) }
    writers { generate(:name) }
    year { 1984 }
    is_scraped { false }
  end

  sequence :name do |n|
    "name #{n}"
  end
end

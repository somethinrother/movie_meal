FactoryBot.define do
  factory :ingredient do
    name { generate(:name) }
  end

  factory :ingredient_recipe do
    recipe { '' }
    ingredient { '' }
  end

  factory :ingredient_mention do
    movie { '' }
    ingredient { '' }
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

  factory :recipe do
    name { generate(:name) }
    thumbnail { 'generic thumbnail' }
  end


end

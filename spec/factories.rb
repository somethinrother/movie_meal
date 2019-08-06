FactoryBot.define do
  factory :movie do
    name { "Movie 1" }
    writers  { "Guy McMan" }
    year { 1984 }
    is_scraped { false }
  end
end

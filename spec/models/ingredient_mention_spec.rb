require 'rails_helper'

RSpec.describe IngredientsMovie, type: :model do
  subject do
    build(:ingredients_movie)
  end

  describe 'when observing relationships' do
    context 'with movies' do
      it 'belongs to a movie' do
        ingredient = create(:ingredient)
        movie = create(:movie)
        ingredients_movie = IngredientsMovie.new(movie_id: movie.id, ingredient_id: ingredient.id)
        expect(ingredients_movie.movie_id).to eq(movie.id)
      end
    end
    context 'with ingredients' do
       it 'belongs to an ingredient' do
         ingredient = Ingredient.new(name: 'Test Ingredient')
         movie = Movie.new(title: 'Test Movie')
         ingredients_movie = IngredientsMovie.new(movie_id: movie.id, ingredient_id: ingredient.id)
         expect(ingredients_movie.ingredient_id).to eq(ingredient.id)
       end
     end
  end
end

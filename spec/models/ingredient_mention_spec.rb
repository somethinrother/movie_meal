require 'rails_helper'

RSpec.describe IngredientMention, type: :model do
  subject do
    build(:ingredient_mention)
  end

  describe 'when observing relationships' do
    context 'with movies' do
      it 'belongs to a movie' do
        ingredient = create(:ingredient)
        movie = create(:movie)
        ingredient_mention = IngredientMention.new(movie_id: movie.id, ingredient_id: ingredient.id)
        expect(ingredient_mention.movie_id).to eq(movie.id)
      end
    end
    context 'with ingredients' do
       it 'belongs to an ingredient' do
         ingredient = Ingredient.new(name: 'Test Ingredient')
         movie = Movie.new(title: 'Test Movie')
         ingredient_mention = IngredientMention.new(movie_id: movie.id, ingredient_id: ingredient.id)
         expect(ingredient_mention.ingredient_id).to eq(ingredient.id)
       end
     end
  end
end

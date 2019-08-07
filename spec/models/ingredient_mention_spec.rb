require 'rails_helper'

RSpec.describe IngredientMention, type: :model do
  subject do
    build(:ingredient_mention)
  end

  describe 'when observing ingredient relationship' do
    it 'belongs to movie pairing' do
      new_ing = Ingredient.new(name: 'Test Ingredient')
      new_movie = Movie.new(title: 'Test Movie')
      new_pairing = create(:ingredient_mention, movie_id: new_movie.id, ingredient_id: new_ing.id)
      expect(new_pairing.ingredient_id).to eq(new_ing.id)
    end

    it 'belongs to ingredient pairing' do
      new_ing = Ingredient.new(name: 'Test Ingredient')
      new_movie = Movie.new(title: 'Test Movie')
      new_pairing = create(:ingredient_mention, movie_id: new_movie.id, ingredient_id: new_ing.id)
      expect(new_pairing.movie_id).to eq(new_movie.id)
    end
  end
end

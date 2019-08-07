require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  subject do
    build(:ingredient)
  end

  describe 'when saving' do
    context 'with valid attributes' do
      it 'saves successfully' do
        expect(subject).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'fails when the name is not unique' do
        ingredient = create(:ingredient, name: subject.name)
        ingredient.save
        expect(subject).to_not be_valid
      end
    end
  end

  describe 'observing relationships' do
    context 'with movies' do
      it 'has multiple ingredient mentions' do
        ingredient = Ingredient.new(name: 'Test Ingredient 1')
        movie = Movie.new(title: 'Test Movie')
        movie2 = Movie.new(title: 'Test Movie 2: Test Harder')
        ingredient_mention = IngredientMention.new(movie_id: movie.id, ingredient_id: ingredient.id)
        ingredient_mention2 = IngredientMention.new(movie_id: movie2.id, ingredient_id: ingredient.id)
        expect(ingredient_mention.movie_id).to eq(ingredient_mention2.movie_id)
      end
    end
  end

end

require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject do
    build(:movie)
  end

  describe 'when saving' do
    context 'with valid attributes' do
      it 'saves successfully' do
        expect(subject).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'fails when the title is not unique' do
        movie = create(:movie, title: subject.title)
        movie.save
        expect(subject).to_not be_valid
      end
    end
  end

  describe 'observing relationships' do
    context 'with ingredients' do
      it 'has multiple movie mentions' do
        ingredient = Ingredient.new(name: "Test Ingredient 1")
        ingredient2 = Ingredient.new(name: 'Test Ingredient 2')
        movie = create(:movie, title: subject.title)
        ingredient_mention = IngredientMention.new(movie_id: movie.id, ingredient_id: ingredient.id)
        ingredient_mention2 = IngredientMention.new(movie_id: movie.id, ingredient_id: ingredient2.id)
        expect(ingredient_mention.movie_id).to eq(ingredient_mention2.movie_id)
      end
    end
  end

end

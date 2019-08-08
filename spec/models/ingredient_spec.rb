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
    context 'with ingredients' do
      it 'has multiple movies' do
        ingredient = create(:ingredient)
        movie = create(:movie)
        movie2 = create(:movie)
        ingredient_mention = create(:ingredient_mention, ingredient_id: ingredient, movie_id: movie)
        ingredient_mention2 = create(:ingredient_mention, ingredient_id: ingredient, movie_id: movie2)

        expect(ingredient.ingredient_mentions.length).to eq(2)
      end
    end
  end
end

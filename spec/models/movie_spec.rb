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
      it 'can own a ingredient' do
        ingredient = create(:ingredient)
        subject.ingredients << ingredient

        expect(subject.ingredients.length).to eq(1)
      end

      it 'can be owned by a ingredient' do
        ingredient = create(:ingredient)
        ingredient.movies << subject

        expect(ingredient.movies).to include(subject)
      end
    end

    context 'with recipes' do
      it 'can own a recipe' do
        recipe = create(:recipe)
        subject.recipes << recipe

        expect(subject.recipes.length).to eq(1)
      end

      it 'can be owned by a recipe' do
        recipe = create(:recipe)
        recipe.movies << subject

        expect(recipe.movies).to include(subject)
      end
    end
  end
end

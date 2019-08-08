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
      it 'can own a movie' do
        movie = create(:movie)
        subject.movies << movie

        expect(subject.movies.length).to eq(1)
      end

      it 'can be owned by a movie' do
        movie = create(:movie)
        movie.ingredients << subject

        expect(movie.ingredients).to include(subject)
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
        recipe.ingredients << subject

        expect(recipe.ingredients).to include(subject)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject do
    build(:recipe)
  end

  describe 'when saving' do
    context 'with valid attributes' do
      it 'saves successfully' do
        expect(subject).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'fails when the name is not unique' do
        recipe = create(:recipe, name: "same")
        subject.name = "same"
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
        movie.recipes << subject

        expect(movie.recipes).to include(subject)
      end
    end

    context 'with ingredients' do
      it 'can own a ingredient' do
        ingredient = create(:ingredient)
        subject.ingredients << ingredient

        expect(subject.ingredients.length).to eq(1)
      end

      it 'can be owned by a ingredient' do
        ingredient = create(:ingredient)
        ingredient.recipes << subject

        expect(ingredient.recipes).to include(subject)
      end
    end
  end
end

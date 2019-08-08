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
      it 'has multiple movies' do

        movie = create(:movie)
        movie2 = create(:movie)

        ingredients_movie = create(:ingredients_movie, ingredient_id: subject.id, movie_id: movie.id)
        ingredients_movie2 = create(:ingredients_movie, ingredient_id: subject.id, movie_id: movie2.id)

        expect(subject.movies.length).to eq(2)
      end
    end
  end
end

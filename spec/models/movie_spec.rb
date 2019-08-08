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
      it 'has multiple ingredients' do
        ingredient = (:ingredient)
        ingredient2 = (:ingredient)
        movie = build(:movie)
        ingredient_mention = build(:ingredient_mention, movie_id: movie.id, ingredient_id: ingredient.id)
        ingredient_mention2 = build(:ingredient_mention, movie_id: movie.id, ingredient_id: ingredient2.id)
        expect(movie.ingredients.length).to eq(2)
      end
    end

    context 'with ingredients' do
      it 'has multiple movie mentions' do
        ingredient = (:ingredient)
        movie = build(:movie)
        movie2 = build(:movie)
        ingredient_mention = build(:ingredient_mention, movie_id: movie.id, ingredient_id: ingredient.id)
        ingredient_mention2 = build(:ingredient_mention, movie_id: movie2.id, ingredient_id: ingredient.id)
        expect(ingredient.movies.length).to eq(2)
      end
    end
  end

end

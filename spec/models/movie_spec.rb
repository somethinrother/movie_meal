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
    context 'with movies' do
      it 'has multiple ingredients' do
        movie = create(:movie)
        ingredient = create(:ingredient)
        ingredient2 = create(:ingredient)


        ingredients_movie = create(:ingredients_movie, movie_id: movie.id, ingredient_id: ingredient.id)
        ingredients_movie2 = create(:ingredients_movie, movie_id: movie.id, ingredient_id: ingredient2.id)
        expect(movie.ingredients_movies.length).to eq(2)
      end
    end

    context 'with ingredients' do
      it 'has multiple ingredient mentions' do
        ingredient = create(:ingredient)
        movie = create(:movie)
        movie2 = create(:movie)
        # byebug
        ingredients_movie = create(:ingredients_movie, movie_id: movie.id, ingredient_id: ingredient.id)
        ingredients_movie2 = create(:ingredients_movie, movie_id: movie2.id, ingredient_id: ingredient.id)
        expect(ingredient.movies.length).to eq(2)
      end
    end
  end

end

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

  describe 'has many' do
    it 'ingredient mentions' do
      new_ing = Ingredient.new(name: "Test Ingredient 1")
      new_ing2 = Ingredient.new(name: 'Test Ingredient 2')
      new_movie = create(:movie, title: subject.title)
      new_pairing = IngredientMention.new(movie_id: new_movie.id, ingredient_id: new_ing.id)
      new_pairing2 = IngredientMention.new(movie_id: new_movie.id, ingredient_id: new_ing2.id)
      expect(new_pairing.movie_id).to eq(new_pairing2.movie_id)
    end
  end

end

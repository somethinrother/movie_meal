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
        expect(Recipe.new(name: "same")).to_not be_valid
      end
    end
  end
end

# cannot write these tests until I implement the appropriate join table
  # describe 'observing relationships' do
  #   context 'with recipe' do
  #     it 'can have multiple movies' do
  #       recipe = create(:recipe, name: subject.name)
  #       movie = Movie.new(title: "One")
  #       movie2 = Movie.new(title: "Two")
  #
  #     end
  #   end
  #   context 'with ingredients' do
  #      it 'belongs to an ingredient' do
  #        ingredient = Ingredient.new(name: 'Test Ingredient')
  #        movie = Movie.new(title: 'Test Movie')
  #        ingredient_mention = IngredientMention.new(movie_id: movie.id, ingredient_id: ingredient.id)
  #        expect(ingredient_mention.ingredient_id).to eq(ingredient.id)
  #      end
  #    end
  #   end

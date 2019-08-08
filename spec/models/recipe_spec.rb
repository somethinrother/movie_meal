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

  describe  'observing relationships' do
    context 'with recipes' do
      it 'has ingredients' do
        recipe = create(:recipe, name: subject.name)
        ingredient = build(:ingredient)
        ingredient2 = build(:ingredient)
        ingredients_recipe = build(:ingredients_recipe, recipe_id: recipe.id, ingredient_id: ingredient.id)
        ingredients_recipe2 = build(:ingredients_recipe, recipe_id: recipe.id, ingredient_id: ingredient2.id)
      expect(recipe).to be_valid
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
  #     it 'can have multiple ingredients' do
  #       ingredient = Ingredient.new(name: 'Test Ingredient')
  #       movie = Movie.new(title: 'Test Movie')
  #       ingredients_movie = IngredientsMovie.new(movie_id: movie.id, ingredient_id: ingredient.id)
  #       expect(ingredients_movie.ingredient_id).to eq(ingredient.id)
  #     end
  #   end
  # end

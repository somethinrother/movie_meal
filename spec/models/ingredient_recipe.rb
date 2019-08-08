require 'rails_helper'

RSpec.describe IngredientsRecipes, type: :model do

  subject do
    build(:ingredient_recipe)
  end

  describe 'when observing relationships' do
    context 'with recipes' do
      it 'belongs to an ingredient' do
        ingredient = Ingredient.new(name: 'Test Ingredient')
        recipe = Recipe.new(name: 'Test Recipe')
        ingredient_recipe = IngredientsRecipes.new(recipe_id: recipe.id, ingredient_id: ingredient.id)
        expect(ingredient_recipe.recipe_id).to eq(recipe.id)
      end
    end
    context 'with ingredients' do
       it 'belongs to an recipe' do
         ingredient = Ingredient.new(name: 'Test Ingredient')
         ingredient2 = Ingredient.new(name: 'Test Ingredient')
         recipe = Recipe.new(name: 'Test Recipe')
         ingredient_recipe2 = IngredientsRecipes.new(recipe_id: recipe.id, ingredient_id: ingredient2.id)
         ingredient_recipe = IngredientsRecipes.new(recipe_id: recipe.id, ingredient_id: ingredient.id)
         ingredient.save
         ingredient2.save
         recipe.save
         ingredient_recipe.save
         ingredient_recipe2.save
         expect(recipe.ingredients.length).to eq(2)
       end
     end
  end

end

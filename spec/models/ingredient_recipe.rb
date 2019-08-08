require 'rails_helper'

RSpec.describe IngredientsRecipes, type: :model do

  subject do
    build(:ingredient_recipe)
  end

  describe 'when observing relationships' do
    context 'with ingredients' do
      it 'has many recipes' do
        ingredient =  create(:ingredient)
        recipe =  create(:recipe)
        recipe2 =  create(:recipe)
        ingredient_recipe =  create(:ingredient_recipe, recipe_id: recipe.id, ingredient_id: ingredient.id)
        ingredient_recipe =  create(:ingredient_recipe, recipe_id: recipe2.id, ingredient_id: ingredient.id)
        expect(ingredient.recipes.length).to eq(2)
      end
    end
    context 'with recipes' do
      it 'has many ingredients' do
        ingredient =  create(:ingredient)
        ingredient =  create(:ingredient)
        recipe =  create(:recipe)
        ingredient_recipe =  create(:ingredient_recipe, recipe_id: recipe.id, ingredient_id: ingredient.id)
        ingredient_recipe2 =  create(:ingredient_recipe, recipe_id: recipe.id, ingredient_id: ingredient2.id)
        expect(recipe.ingredients.length).to eq(2)
       end
     end
  end

end

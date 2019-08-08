require 'rails_helper'

RSpec.describe UsedIngredient, type: :model do

  subject do
    build(:used_ingredient)
  end

  describe 'when observing relationships' do
    context 'with recipes' do
      it 'belongs to an ingredient' do
        ingredient = Ingredient.new(name: 'Test Ingredient')
        recipe = Recipe.new(name: 'Test Recipe')
        ingredient_mention = UsedIngredient.new(recipe_id: recipe.id, ingredient_id: ingredient.id)
        expect(ingredient_mention.recipe_id).to eq(recipe.id)
      end
    end
    context 'with ingredients' do
       it 'belongs to an recipe' do
         ingredient = Ingredient.new(name: 'Test Ingredient')
         recipe = Recipe.new(name: 'Test Recipe')
         ingredient_mention = UsedIngredient.new(recipe_id: recipe.id, ingredient_id: ingredient.id)
         expect(ingredient_mention.ingredient_id).to eq(ingredient.id)
       end
     end
  end

end

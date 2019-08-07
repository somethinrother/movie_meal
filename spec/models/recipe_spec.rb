require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject do
    build(:recipe)
  end

  describe 'when saving' do
    context 'has valid attributes' do
      it 'saves successfully' do
        expect(subject).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'fails when the name is not unique' do
        recipe = create(:recipe, name: subject.name)
        recipe.save
        expect(subject).to_not be_valid
      end
    end
  end


end

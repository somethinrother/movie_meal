require 'rails_helper'

RSpec.describe Cocktail, type: :model do
  subject do
    build(:cocktail)
  end

  describe 'when saving' do
    context 'with valid attributes' do
      it 'saves successfully' do
        expect(subject).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'fails when the name is not unique' do
        cocktail = create(:cocktail, name: subject.name)
        expect(subject).to_not be_valid
      end
    end
  end

  describe 'when adding ingredients' do
    context 'with valid attributes' do
      it 'saves successfully' do
        ingredient = create(:ingredient)
        subject.ingredients << ingredient
        expect(subject.ingredients.length).to eq(1)
      end
    end

    context 'can have multiple ingredients' do
      it 'saves successfully' do
        ingredient = create(:ingredient)
        ingredient2 = create(:ingredient)
        subject.ingredients << ingredient
        subject.ingredients << ingredient2
        expect(subject.ingredients.length).to eq(2)
      end
    end
  end
end

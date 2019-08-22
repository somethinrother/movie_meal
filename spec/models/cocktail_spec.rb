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
        cocktail.save
        expect(subject).to_not be_valid
      end
    end
  end
end

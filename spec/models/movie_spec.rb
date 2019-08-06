require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject do
    create(:movie)
  end

  describe 'when saving' do
    context 'with valid attributes' do
      it 'saves successfully' do
        expect(subject).to be_valid
      end
    end
  end
end

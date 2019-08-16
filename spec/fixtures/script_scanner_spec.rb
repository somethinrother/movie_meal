require 'rails_helper'
require 'spec_helper'

RSpec.describe Movie, type: :model do
	subject do
    build(:movie)
  end

# test to check ot make sure duplicate join table mentions are not made
	describe 'when saving script' do
		context 'if empty' do
			it 'populates script' do
				movie = create(:movie)
				movie.script = ''
				movie.script << "test script"
				expect(movie.script).to eq("test script")
			end
		end
	end
end

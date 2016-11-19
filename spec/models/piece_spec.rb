require 'rails_helper'

RSpec.describe Piece, type: :model do

  describe 'a Pawn' do
    it 'should be a pawn' do
      pawn = create(:pawn)
      expect(pawn.type).to eq 'Pawn'
    end
  end

end

describe "Pawn#valid_move?(destination_x, destination_y)" do
    
    let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }
    let(:pawn) { FactoryGirl.create(:pawn, game_id: game.id, player_id: white_player.id) }
    let(:game) { FactoryGirl.create(:game) }
    
    subject { pawn.valid_move?(destination_x, destination_y) }
    
    context "valid move for first move" do
      let(:destination_x) { 1 }
      let(:destination_y) { 2 }
      
      it "should return true if the white pawn is moving 1 or 2 squares up for first move" do
        expect(subject).to eq(true)
      end
    end

     context "valid move for any move" do
      let(:destination_x) { 1 }
      let(:destination_y) { 2 } 

      it "should return true if the white pawn is moving 1 square up for any move" do 
        expect(subject).to eq(true)
      end
    end
    
    context "invalid move" do
      let(:destination_x) { 4 }
      let(:destination_y) { 3 }
      
      it "should return false if the pawn tries to move outside of its constraints" do
        expect(subject).to eq(false)
      end
    end
    
    context "no move" do
      let(:destination_x) { 4 }
      let(:destination_y) { 4 }
      
      it "should return false if the pawn tries to move on top of itself" do
        expect(subject).to eq(false)
      end
    end
    
  end

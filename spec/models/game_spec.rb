require 'rails_helper'

<<<<<<< HEAD
RSpec.describe Game, type: :model do
  
end

=======
>>>>>>> master
RSpec.describe Game, type: :model do
  
  describe "is_available" do
    
    it "should return only games that are available" do
      Game.create("name" => "touchdown", "white_player_id" => 0)
      @games = Game.all.is_available
      expect(@games.last.name).to eq("touchdown")
    end
  end
end

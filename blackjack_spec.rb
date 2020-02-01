require_relative 'blackjack'

RSpec.describe Blackjack do
  describe "instance methods" do
    SUITS = ["Hearts", "Clubs", "Spades", "Diamonds"]
    RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

    before do
      @blackjack = Blackjack.new(SUITS, RANKS)
    end

    it "should respond to player_hand" do
      expect(@blackjack).to respond_to(:player_hand)
    end

    it "should respond to dealer_hand" do
      expect(@blackjack).to respond_to(:dealer_hand)
    end

    it "should respond to playing" do
      expect(@blackjack).to respond_to(:playing)
    end

    it "should respond to current_gamer" do
      expect(@blackjack).to respond_to(:current_gamer)
    end

    it "should respond to deal" do
      expect(@blackjack).to respond_to(:deal)
    end

    it "should respond to hit" do
      expect(@blackjack).to respond_to(:hit)
    end

    it "should respond to stand" do
      expect(@blackjack).to respond_to(:stand)
    end

    it "should respond to show_hands" do
      expect(@blackjack).to respond_to(:show_hands)
    end

    it "should respond to set_result" do
      expect(@blackjack).to respond_to(:set_result)
    end
  end
end

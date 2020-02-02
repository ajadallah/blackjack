require_relative 'blackjack'
require_relative 'deck'

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

  describe 'Dealing cards' do
    before do
      @blackjack = Blackjack.new(SUITS, RANKS)
      @blackjack.deal
      @player_cards = @blackjack.player_hand.dealt_cards
      @dealer_cards = @blackjack.dealer_hand.dealt_cards
    end

    it "Should return 2 cards for the dealer and player" do
      expect(@player_cards.count).to eq(2)
      expect(@dealer_cards.count).to eq(2)
    end

    it "Should not display dealers first card" do
      expect(@dealer_cards.first.show).to eq(false)
    end

    it "Should end the players turn if a blackjack is dealt" do
      card_1 = Card.new('Hearts', '3')
      card_2 = Card.new('Hearts', 'Ace')
      card_3 = Card.new('Hearts', '5')
      card_4 = Card.new('Hearts', 'Jack')

      @blackjack = Blackjack.new(SUITS, RANKS)
      new_deck = [card_2, card_1, card_4, card_3]

      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal

      expect(@blackjack.current_gamer).to eq('Dealer')
    end
  end

  describe "hitting a hand" do

    before do
      @blackjack = Blackjack.new(SUITS, RANKS)
      @blackjack.deal
      @player_cards = @blackjack.player_hand.dealt_cards
      @dealer_cards = @blackjack.dealer_hand.dealt_cards
    end

    it "should only hit if playing is true" do
      expect(@blackjack.playing).to eq(true)
    end

    it "Should return three cards for the player and two for the dealer" do
      @blackjack.hit
      expect(@player_cards.count).to eq(3)
      expect(@dealer_cards.count).to eq(2)
    end

    it "Should return if the player has busted" do
      card_1 = Card.new('Hearts', '3')
      card_2 = Card.new('Hearts', 'King')
      card_3 = Card.new('Hearts', '10')
      card_4 = Card.new('Hearts', 'Jack')
      card_5 = Card.new('Hearts', 'Jack')
      card_6 = Card.new('Hearts', 'Jack')

      @blackjack = Blackjack.new(SUITS, RANKS)
      new_deck = [card_1, card_2, card_3, card_4, card_5, card_6]
      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal
      @blackjack.hit

      expect(@blackjack.result).to eq('Player busted!')


    end

    it "Should return if the player has busted" do
      card_1 = Card.new('Hearts', '3')
      card_2 = Card.new('Hearts', 'King')
      card_3 = Card.new('Hearts', 'Ace')
      card_4 = Card.new('Hearts', 'Jack')
      card_5 = Card.new('Hearts', 'Jack')
      card_6 = Card.new('Hearts', 'Jack')

      @blackjack = Blackjack.new(SUITS, RANKS)
      new_deck = [card_1, card_2, card_3, card_4, card_5, card_6]
      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal
      @blackjack.current_gamer = 'Dealer'
      @blackjack.hit

      expect(@blackjack.result).to eq('Dealer busted!')
    end
  end

  describe "Standing" do
    before do
      @blackjack = Blackjack.new(SUITS, RANKS)
    end

    it "Should switch current gamer from player to dealer" do
      card_1 = Card.new('Hearts', '3')
      card_2 = Card.new('Hearts', 'King')
      card_3 = Card.new('Hearts', '5')
      card_4 = Card.new('Hearts', 'Jack')
      card_5 = Card.new('Hearts', '5')
      card_6 = Card.new('Hearts', 'Jack')

      new_deck = [card_1, card_2, card_3, card_4, card_5, card_6]
      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal
      @blackjack.stand

      expect(@blackjack.current_gamer).to eq('Dealer')
    end

    it "Dealer should hit when total value of cards is less than 17" do
      card_1 = Card.new('Hearts', '3')
      card_2 = Card.new('Hearts', 'King')
      card_3 = Card.new('Hearts', '5')
      card_4 = Card.new('Hearts', '10')
      card_5 = Card.new('Hearts', '5')
      card_6 = Card.new('Hearts', '6')

      new_deck = [card_1, card_2, card_3, card_4, card_5, card_6]
      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal

      expect(@blackjack.dealer_hand.get_value).to eq(16)
      @blackjack.stand

      expect(@blackjack.dealer_hand.get_value).to eq(26)
      expect(@blackjack.dealer_hand.dealt_cards.first.show).to eq(true)
    end
  end

  describe "Showing hands" do
    before do
      @blackjack = Blackjack.new(SUITS, RANKS)
      @blackjack.deal
    end

    it "Should return the gamer's hands" do
      expect(@blackjack.show_hands).to match(/Player's hand:/)
      expect(@blackjack.show_hands).to match(/Dealer's hand:/)
    end
  end

  describe "Setting result" do
    before do
      @blackjack = Blackjack.new(SUITS, RANKS)
      @blackjack.deal
    end

    it "Returns if player busts" do
      card_1 = Card.new('Hearts', '3')
      card_2 = Card.new('Hearts', 'Queen')
      card_3 = Card.new('Hearts', 'King')
      card_4 = Card.new('Hearts', '10')
      card_5 = Card.new('Hearts', '10')
      card_6 = Card.new('Hearts', '8')

      new_deck = [card_1, card_2, card_3, card_4, card_5, card_6]
      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal
      @blackjack.hit #Player hits and busts

      expect(@blackjack.set_result).to eq("Player busts!")
    end

    it "Returns if dealer busts" do
      card_1 = Card.new('Hearts', '3')
      card_2 = Card.new('Hearts', 'Queen')
      card_3 = Card.new('Hearts', 'King')
      card_4 = Card.new('Hearts', '10')
      card_5 = Card.new('Clubs', '10')
      card_6 = Card.new('Hearts', 'Jack')

      new_deck = [card_1, card_2, card_3, card_4, card_5, card_6]
      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal
      @blackjack.stand #Player stands with 20
      @blackjack.hit #Dealer hits and busts

      expect(@blackjack.set_result).to eq("Dealer busts!")
    end

    it "Returns if there is a tie" do
      card_1 = Card.new('Clubs', 'Ace')
      card_2 = Card.new('Hearts', 'Ace')
      card_3 = Card.new('Hearts', 'King')
      card_4 = Card.new('Hearts', '10')
      card_5 = Card.new('Clubs', '10')
      card_6 = Card.new('Hearts', 'Jack')

      new_deck = [card_1, card_2, card_3, card_4, card_5, card_6]
      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal
      @blackjack.hit #Player hits
      @blackjack.stand #Player stands with 21
      @blackjack.hit #Dealer hits and busts

      expect(@blackjack.set_result).to eq("It is a tie!")
    end

    it "Returns if player wins" do
      card_1 = Card.new('Clubs', 'Ace')
      card_2 = Card.new('Hearts', 'Ace')
      card_3 = Card.new('Hearts', 'King')
      card_4 = Card.new('Hearts', '10')
      card_5 = Card.new('Clubs', '10')
      card_6 = Card.new('Hearts', '9')

      new_deck = [card_1, card_2, card_3, card_4, card_5, card_6]
      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal
      @blackjack.stand

      expect(@blackjack.set_result).to eq("Player wins!")
    end

    it "Returns if dealer wins" do
      card_1 = Card.new('Clubs', 'Ace')
      card_2 = Card.new('Hearts', 'Ace')
      card_3 = Card.new('Hearts', 'King')
      card_4 = Card.new('Hearts', '10')
      card_5 = Card.new('Clubs', '9')
      card_6 = Card.new('Hearts', 'Queen')

      new_deck = [card_1, card_2, card_3, card_4, card_5, card_6]
      @blackjack.deck.replace_with(new_deck)
      @blackjack.deal
      @blackjack.stand

      expect(@blackjack.set_result).to eq("Dealer wins!")
    end
  end



end

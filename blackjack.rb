require_relative 'deck'

class Blackjack
  SUITS = ["Hearts", "Clubs", "Spades", "Diamonds"]
  RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

  attr_reader(
    :player_hand,
    :dealer_hand,
    :deck,
    :playing
  )

  attr_accessor(
    :current_gamer
  )
  def initialize(suits, ranks)
      @player_hand = nil
      @dealer_hand = nil
      @deck = Deck.new(suits, ranks)
      @deck.shuffle
  end

  def deal

  end

  def stand

  end

  def hit

  end

  def show_hands

  end

  def set_results

  end
end

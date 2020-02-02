require_relative 'deck'
require_relative 'hand'

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
      @playing = false
      @current_gamer = ''
  end

  def deal
    @dealer_hand = Hand.new
    @player_hand = Hand.new

    2.times do
      @dealer_hand.add_card(@deck.deal_card)
      @player_hand.add_card(@deck.deal_card)
    end
    @dealer_hand.dealt_cards.first.show = false
    @playing = true

    player_cards = @player_hand.dealt_cards
    value_of_ten = ['10', 'Jack', 'Queen', 'King']

    if value_of_ten.include?(player_cards.first.rank) &&
      player_cards.last.rank == 'Ace' ||
      value_of_ten.include?(player_cards.last.rank) &&
      player_cards.first.rank == 'Ace'
      @current_gamer = 'Dealer'
    end
  end

  def stand

  end

  def hit

  end

  def show_hands

  end

  def set_result

  end
end

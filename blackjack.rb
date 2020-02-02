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
    :current_gamer, :result
  )
  def initialize(suits, ranks)
      @player_hand = nil
      @dealer_hand = nil
      @deck = Deck.new(suits, ranks)
      @deck.shuffle
      @playing = false
      @current_gamer = 'Player'
      @result = ''
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
    if playing
      if @current_gamer == 'Player'
        @current_gamer = 'Dealer'
        @dealer_hand.dealt_cards.first.show = true
      end
      if @dealer_hand.get_value < 17
        hit
      end
    end
  end

  def hit
    if playing
      if @current_gamer == 'Player'
        add_new_card(@player_hand)
      elsif @current_gamer == 'Dealer'
        add_new_card(@dealer_hand)
      end
    end
  end

  def show_hands
    "Player's hand: #{player_hand}\nDealer's hand: #{dealer_hand}"
  end

  def set_result
    if @player_hand.get_value > 21
      @result = "Player busts!"
    elsif @dealer_hand.get_value > 21
      @result = "Dealer busts!"
    elsif @current_gamer == 'Dealer'
      if @player_hand.get_value == @dealer_hand.get_value
        @result = "It is a tie!"
      elsif @player_hand.get_value > @dealer_hand.get_value
        @result = "Player wins!"
      elsif @player_hand.get_value < @dealer_hand.get_value
        @result = "Dealer wins!"
      end
    end
  end

  private

  def add_new_card(hand)
    hand.add_card(@deck.deal_card)
    if hand.get_value > 21
      @result = "#{@current_gamer} busted!"
      @playing = false
    end
  end
end

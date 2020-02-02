require_relative 'blackjack'

SUITS = ["Hearts", "Clubs", "Spades", "Diamonds"]
RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

game = Blackjack.new(SUITS, RANKS)

game.deal
puts game

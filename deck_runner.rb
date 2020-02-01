require_relative 'deck'

SUITS = ["Hearts", "Clubs", "Spades", "Diamonds"]
RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

deck = Deck.new(SUITS, RANKS)

puts deck.deck

deck.shuffle
puts "----------Shuffle----------"
puts deck.deck

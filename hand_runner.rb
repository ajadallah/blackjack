require_relative 'card'
require_relative 'hand'

player_hand = Hand.new
puts "Player's hand"
player_hand.add_card(Card.new('Hearts', '8'))
player_hand.add_card(Card.new('Spades', '10'))
puts player_hand

dealer_hand = Hand.new
puts "Dealer's hand"
dealer_hand.add_card(Card.new('Clubs', 'Queen'))
dealer_hand.add_card(Card.new('Diamonds', 'Ace'))
puts dealer_hand

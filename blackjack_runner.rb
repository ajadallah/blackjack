require_relative 'blackjack'

SUITS = ["Hearts", "Clubs", "Spades", "Diamonds"]
RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

game = Blackjack.new(SUITS, RANKS)

game.deal
puts game.show_hands

while game.player_hand.get_value <= 21 do
  puts
  puts "Do you want to hit (1) or stand (2)"
  res = gets.chomp

  if res == '1'
    game.hit
    puts "Player hand: " + game.player_hand.to_s
    puts "Dealer hand: " + game.dealer_hand.to_s
  elsif res == '2'
    puts
    game.stand
    puts "Player hand: " + game.player_hand.to_s
    puts "Dealer hand: " + game.dealer_hand.to_s
    break
  end



end

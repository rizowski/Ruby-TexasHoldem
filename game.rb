require_relative 'Deck'
require_relative 'hand'
require_relative 'player'
class Game
	attr_accessor :players
	attr_reader :winner, :deck, :house_cards, :player_count

	def initialize
		@deck = Deck.new
		start
	end

	# sets up players
	def start
		players = []
		@player_count = Random.rand(8)
		@player_count.times do |count|
			hand = Hand.new @deck.get_pocket_cards
			players << Player.new(hand)
		end
		@house_cards = @deck.get_dealt_cards
	end

	def play

	end

	#private
	def fold

	end

	def evaluate_hand player
		temp_hand << @house_cards
		temp_hand << player.hand.cards
		temp_hand.flatten!

		combinations = temp_hand.combination(5).to_a

		high_hand_value = 0
		combinations.each do |cards|

		end
	end

	def find_point_value cards
		suit_match = true
		cards.sort_by! {|card| card.value}
		first_suit = cards.first.suit
		last_card_value = cards.first.value-1 # no bad ok oh well
		straight_match = true

		cards.each_with_index do |card,index|
			suit_match = suit_match && (card.suit == first_suit)
			straight_match = straight_match && ((card.value - last_card_value) == 1)
			last_card_value = card.value
		end
		straight_match
	end
end

g = Game.new

g.start
puts g.find_point_value [Card.new("C",1),Card.new("D",2),Card.new("D",3),Card.new("D",4),Card.new("D",5)]

2,2 #two of a kind
22, 33 #2pair
12345# straight
DDDDD #flush
D4,S4,C4,H4 #four of a kind
DDD,SS #full house
555 #three of a kind

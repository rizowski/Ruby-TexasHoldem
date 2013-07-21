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
		last_card_value_for_matching = cards.first.value
		straight_match = true

		cards.each_with_index do |card,index|
			suit_match = suit_match && (card.suit == first_suit)
			straight_match = straight_match && ((card.value - last_card_value) == 1)
			last_card_value = card.value
		end
		count_of = Array.new
		index_count = 0
		while index_count < 5
		  card_selected = cards[index_count]
		  number_of = cards.select{|card| card.value == card_selected.value}.count
		  index_count += number_of
		  count_of.push(number_of)
		end
		if suit_match && straight_match
		  return 10
		elsif count_of.include?(4)
		  return 9
		elsif count_of.include?(3) && count_of.include?(2)
		  return 8
		elsif suit_match
		  return 7
		elsif straight_match
		  return 6
		elsif count_of.include?(3)
		  return 5
		elsif count_of.include?(2) && count_of.length == 3
		  return 4
		elsif count_of.include?(2)
		  return 3
		else
		  return 0                
		end
	end
end

g = Game.new

g.start
puts g.find_point_value [Card.new("D",1),Card.new("C",12),Card.new("C",4),Card.new("C",3),Card.new("C",5)]

# 2,2 #two of a kind
# 22, 33 #2pair
# 12345# straight
# DDDDD #flush
# D4,S4,C4,H4 #four of a kind
# DDD,SS #full house
# 555 #three of a kind

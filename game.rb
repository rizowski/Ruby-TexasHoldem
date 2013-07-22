require_relative 'Deck'
require_relative 'hand'
require_relative 'player'
class Game
	attr_accessor :players
	attr_reader :winner, :deck, :house_cards, :player_count, :winner_slot

	def initialize
		@deck = Deck.new
		start
	end

	# sets up players
	def start
		players = []
		@player_count = (2..10).to_a.sample
		@player_count.times do |count|
			hand = Hand.new @deck.get_pocket_cards
			players << Player.new(hand)
		end
		@house_cards = @deck.get_dealt_cards
		players.each_with_index do |player, index|
			puts "player #{index+1}"
			someString = ""
			unless Random.rand(4) == 1
				evaluate_hand(player).each do |card|
					someString += " #{card}"
				end
			else
				player.hand.value = -1
				someString += "#{player.hand.to_s} (Fold)"
			end
	    	puts someString		  
		end
		@winner = players.first
		players.each_with_index do |player, index|
			@winner_slot = "#{index+1}"
			if @winner.hand.value > player.hand.value
				slot = index
				@winner = player
				@winner_slot = index+1
			end
			
		end
		puts "Winner is Player #{@winner_slot}"
	end

	#private
	def fold

	end

	def evaluate_hand player
	  temp_hand = []
		temp_hand << @house_cards
		temp_hand << player.hand.cards
		temp_hand.flatten! 
		player.hand.value = 0
		combinations = temp_hand.combination(5)
		high_hand_value = 0
		high_hand = combinations.first
		combinations.each do |cards|
	      value_of_hand = find_point_value(cards)
	      if value_of_hand > high_hand_value
	        high_hand_value = value_of_hand
	        high_hand = cards
	        player.hand.value = high_hand_value
	      end
		end
		high_hand
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

# 2,2 #two of a kind
# 22, 33 #2pair
# 12345# straight
# DDDDD #flush
# D4,S4,C4,H4 #four of a kind
# DDD,SS #full house
# 555 #three of a kind

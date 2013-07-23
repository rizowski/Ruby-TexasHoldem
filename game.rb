require_relative 'Deck'
require_relative 'hand'
require_relative 'player'
class Game
	attr_reader :players, :winner, :deck, :house_cards, :player_count

	def initialize
		@deck = Deck.new
		start
	end

	# sets up players
	def start
		setup_players
		@house_cards = @deck.deal_house		
		@players.each_with_index do |player, index|
			puts "player #{index+1}"
			someString = ""
			unless Random.rand(4) == 1
				hand = evaluate_hand(player)
				print "(#{player.hand.value})"
				hand.each do |card|
					someString += " #{card}"
				end
			else
				player.fold = true
				someString += "(0) #{player.hand.to_s} (Fold)"
			end
	    	puts someString		  
		end
		@winner = @players.first
		@players.each_with_index do |player, index|
			unless player.fold
				if @winner.hand.value < player.hand.value
					@winner = player
				end
			end			
		end
		puts "Player #{@winner.name} Wins"
	end

	def setup_players
		@players = []
		@player_count = (2..10).to_a.sample
		num = 0
		@player_count.times do |count|
			num += 1
			hand = Hand.new @deck.deal_player	
			@players << Player.new(num, hand)
		end
	end

	#private
	def fold

	end

	def evaluate_hand player
		player_cards = []
		player_cards << player.hand.cards
		player_cards << @house_cards
		player_cards.flatten!

		player.hand.value = 0
		high_hand_value = 0

		combinations = player_cards.combination(5)
		high_hand = combinations.first

		combinations.each do |cards|
	      value_of_hand = find_hand_value(cards)
	      if value_of_hand > high_hand_value
	        high_hand_value = value_of_hand
	        high_hand = cards
	        player.hand.value = high_hand_value
	      end
		end
		high_hand
	end

	def find_hand_value game_cards
		game_cards.sort_by! do |card| 
			card.value 
		end

		suit_match = suit_match? game_cards
		straight = straight? game_cards
		high_card = high_card game_cards
		duplicate_count = count_duplicates game_cards

		if suit_match && straight
			return 112 + high_card.value
		elsif duplicate_count.include?(4)
			return 98 + high_card.value
		elsif duplicate_count.include?(3) && duplicate_count.include?(2)
			return 84 + high_card.value
		elsif suit_match
			return 70 + high_card.value
		elsif straight
			return 56 + high_card.value
		elsif duplicate_count.include?(3)
			return 42 + high_card.value
		elsif duplicate_count.include?(2) && duplicate_count.select{|num| num == 2}.length() == 2
			return 28 + high_card.value
		elsif duplicate_count.include?(2)
			return 14 + high_card.value
		else
			return high_card.value
		end		
	end

	def high_card cards
		cards.sort_by! do |card|
			card.value
		end
		cards.last
	end

	def suit_match? cards
		suit_match = true
		first_suit = cards.first.suit
		cards.each do |card|
			suit_match = suit_match && (card.suit == first_suit)
		end
		suit_match
	end

	def straight? cards
		cards.sort_by! do |card|
			card.value
		end
		straight_match = true
		last_card_value = cards.last.value
		
		cards.each do |card|
			straight_match = straight_match && ((card.value - last_card_value) == 1)
		end
		straight_match
	end

	def count_duplicates cards
		index = 0
		count = []
		while index < 5
			card_selected = cards[index]
		  	number = cards.select{|card| card.value == card_selected.value}.count
		  	index += number
		  	count.push(number)
		end
		count
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

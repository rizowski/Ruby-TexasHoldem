class Hand
	attr_accessor :cards

	def initialize

	end

	def cards card_values
		raise TooManyCardsException if card_values > 5
		
	end

	#prints all the cards in the hand
	def get_cards

	end

end
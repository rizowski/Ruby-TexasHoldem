class Hand
	attr_accessor :cards, :value

	def initialize cards
		@cards = cards
	end

	#prints all the cards in the hand
	def cards_value
		
	end

	def to_s
		some_string = ""
		@cards.each do |card|
			some_string += " #{card}"
		end 
		some_string
	end

end
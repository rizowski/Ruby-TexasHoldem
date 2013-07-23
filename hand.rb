class Hand
	attr_accessor :cards, :value

	def initialize cards
		@cards = cards
	end

	def to_s
		some_string = ""
		@cards.each do |card|
			some_string += " #{card}"
		end 
		some_string
	end


end
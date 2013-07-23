class Player
	attr_accessor :hand, :fold, :name

	def initialize name, hand
		@name = name
		@hand = hand
		@fold = false
	end
end
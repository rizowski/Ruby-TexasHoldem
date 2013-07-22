require 'rspec'
require_relative '../game.rb'
require_relative '../card.rb'

describe Game do 
	before :all do
		@game = Game.new
	end
	
	it "checks to see if the player has a Royal Flush" do
		cards = [Card.new("D",10),Card.new("D",11),Card.new("D",12),Card.new("D",13),Card.new("D",9)]
		value = @game.find_point_value cards
		expect(value).to eq(10)
	end
	it "checks to see if the player has a Straight Flush" do

	end
	it "checks to see if the player has a Four of a kind" do

	end
	it "checks to see if the player has a Full house" do

	end
	it "checks to see if the player has a Flush" do

	end
	it "checks to see if the player has a Straight" do

	end
	it "checks to see if the player has a Three of a kind" do

	end
	it "checks to see if the player has a Two Pair" do

	end
	it "checks to see if the player has a Pair" do

	end
	it "checks to see if the player has a High Card" do

	end
end
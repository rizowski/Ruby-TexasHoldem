require_relative 'card'
class Deck
  attr_accessor :deck_cards
  def initialize
    @deck_cards = Array.new
    fill_deck  
  end
  def fill_deck
    13.times do |i|
      @deck_cards.push(Card.new("S", i+1))
    end
    13.times do |i|
      @deck_cards.push(Card.new("H", i+1))
    end
    13.times do |i|
      @deck_cards.push(Card.new("C", i+1))
    end
    13.times do |i|
      @deck_cards.push(Card.new("D", i+1))
    end
  end
  def get_pocket_cards
    @deck_cards.sample(2)
  end
  def get_dealt_cards
    @deck_cards.sample(5)
  end
end

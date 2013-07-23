require_relative 'card'
class Deck
  attr_accessor :deck_cards

  def initialize
    @deck_cards = Array.new
    fill_deck  
  end

  def fill_deck
    13.times do |i|
      @deck_cards.push(Card.new("S", i))
    end
    13.times do |i|
      @deck_cards.push(Card.new("H", i))
    end
    13.times do |i|
      @deck_cards.push(Card.new("C", i))
    end
    13.times do |i|
      @deck_cards.push(Card.new("D", i))
    end
  end

  def deal_player    
    @deck_cards.sample(2)
  end

  def deal_house    
    @deck_cards.sample(5)
  end
end

require_relative 'card'

class Deck
  SUITS = [:S, :H, :C, :D]

  attr_reader :cards
  
  def initialize
    @cards = SUITS.flat_map do |suit|
      (1..13).map { |value| Card.new(value, suit) }
    end
  end

  def draw_card
    @cards.pop
  end
end

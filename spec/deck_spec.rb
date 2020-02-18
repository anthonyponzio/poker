require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  context '#initialize' do    
    it 'should initialize with 52 cards' do
      expect(deck.cards.length).to eq(52)
    end

    it 'should contain 13 cards of each suit' do
      suits = Hash.new(0)
      deck.cards.each { |card| suits[card.suit] += 1 }
      
      expect(suits[:H]).to eq(13)
      expect(suits[:D]).to eq(13)
      expect(suits[:C]).to eq(13)
      expect(suits[:S]).to eq(13)
    end
  end

  context '#draw_card' do
    it 'should return the top card from the deck' do
      top_card = deck.cards.last

      expect(deck.draw_card).to be(top_card)
    end

    it 'should mutate the deck' do
      length_before_draw = deck.cards.length
      drawn_card = deck.draw_card
      
      expect(deck.cards.length).to not_eq(length_before_draw)
      expect(deck.cards.last).to not_be(drawn_card)
    end
  end
end
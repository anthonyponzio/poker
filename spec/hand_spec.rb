require 'rspec'
require 'hand'
require 'card'

describe Hand do  
  context '#initialize' do
    cards = [Card.new(1, :D), Card.new(2, :D), Card.new(3, :D), Card.new(4, :D), Card.new(5, :D)]
    hand = Hand.new(cards)
    it 'should take array of 5 cards and set it to @cards' do
      expect(hand.cards.length).to eq(5)
    end
  end

  context '#detect_hand' do
    it 'should detect straight flush' do
      cards = [Card.new(1, :D), Card.new(2, :D), Card.new(3, :D), Card.new(4, :D), Card.new(5, :D)]
      hand = Hand.new(cards)

      expect(hand.detect_hand).to eq('straight flush')
    end

    it 'should detect four of a kind' do
      cards = [Card.new(12, :D), Card.new(12, :C), Card.new(12, :H), Card.new(12, :S), Card.new(5, :D)]
      hand = Hand.new(cards)
      
      expect(hand.detect_hand).to eq('four of a kind')
    end

    it 'should detect full house' do
      cards = [Card.new(1, :D), Card.new(1, :H), Card.new(1, :C), Card.new(4, :D), Card.new(4, :H)]
      hand = Hand.new(cards)

      expect(hand.detect_hand).to eq('full house')
    end

    it 'should detect flush' do
      cards = [Card.new(1, :D), Card.new(8, :D), Card.new(3, :D), Card.new(4, :D), Card.new(5, :D)]
      hand = Hand.new(cards)      

      expect(hand.detect_hand).to eq('flush')
    end

    it 'should detect straight' do
      cards = [Card.new(1, :D), Card.new(2, :C), Card.new(3, :H), Card.new(4, :D), Card.new(5, :S)]
      hand = Hand.new(cards)

      expect(hand.detect_hand).to eq('straight')
    end

    it 'should detect three of a kind' do
      cards = [Card.new(4, :D), Card.new(4, :C), Card.new(4, :C), Card.new(11, :D), Card.new(9, :D)]
      hand = Hand.new(cards)
      
      expect(hand.detect_hand).to eq('three of a kind')
    end

    it 'should detect two pair' do
      cards = [Card.new(1, :D), Card.new(1, :H), Card.new(3, :C), Card.new(5, :D), Card.new(5, :S)]
      hand = Hand.new(cards)
      
      expect(hand.detect_hand).to eq('two pair')
    end

    it 'should detect one pair' do
      cards = [Card.new(10, :H), Card.new(12, :S), Card.new(4, :S), Card.new(10, :D), Card.new(5, :C)]
      hand = Hand.new(cards)

      expect(hand.detect_hand).to eq('one pair')
    end
  end
end
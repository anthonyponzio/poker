require 'rspec'
require 'hand'
require 'card'

describe Hand do
  
  subject(:hand) { Hand.new(cards) }
  let(:cards) { [Card.new(1, :D), Card.new(2, :D), Card.new(3, :D), Card.new(4, :D), Card.new(5, :D)] }
  
  context '#initialize' do
    it 'should take array of 5 cards and set it to @cards' do
      expect(hand.cards.length).to eq(5)
    end
  end

  context '#detect_hand' do
    it 'should detect straight flush' do
      expect(hand.detect_hand).to eq('straight flush')
    end

    let(:cards) { [Card.new(12, :D), Card.new(12, :C), Card.new(12, :H), Card.new(12, :S), Card.new(5, :D)] }
    it 'should detect four of a kind' do
      expect(hand.detect_hand).to eq('four of a kind')
    end

    let(:cards) { [Card.new(1, :D), Card.new(1, :H), Card.new(1, :C), Card.new(4, :D), Card.new(4, :H)] }
    it 'should detect full house' do
      expect(hand.detect_hand).to eq('full house')
    end

    let(:cards) { [Card.new(1, :D), Card.new(2, :D), Card.new(3, :D), Card.new(4, :D), Card.new(5, :D)] }
    it 'should detect flush' do
      expect(hand.detect_hand).to eq('flush')
    end

    let(:cards) { [Card.new(1, :D), Card.new(2, :C), Card.new(3, :H), Card.new(4, :D), Card.new(5, :S)] }
    it 'should detect straight' do
      expect(hand.detect_hand).to eq('staight')
    end

    let(:cards) { [Card.new(4, :D), Card.new(2, :D), Card.new(13, :D), Card.new(11, :D), Card.new(9, :D)] }
    it 'should detect three of a kind' do
      expect(hand.detect_hand).to eq('three of a kind')
    end

    let(:cards) { [Card.new(1, :D), Card.new(1, :H), Card.new(3, :C), Card.new(5, :D), Card.new(5, :S)] }
    it 'should detect two pair' do
      expect(hand.detect_hand).to eq('two pair')
    end

    let(:cards) { [Card.new(10, :H), Card.new(12, :S), Card.new(4, :S), Card.new(10, :D), Card.new(5, :C)] }
    it 'should detect one pair' do
      expect(hand.detect_hand).to eq('one pair')
    end
  end

  # context '#hand_score' do
  #   it 'should return hash containing score and high_card'
  # end
end